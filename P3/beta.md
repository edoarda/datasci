# Teste

O paper, na verdade, é composto de vários experimentos menores. esses foram destrinchados a seguir:
**Reconstruction of biosphere-level metabolism**

1. Assembly of all known metabolic reactions into a biosphere-level (or pangenome) metabolic model using the KEGG[^1] database. 
    * Download using the [KEGG REST API](http://www.kegg.jp/kegg/docs/keggapi.html). 
    * Construct a stoichiometric matrix[^2] from the KEGG reaction database using reaction equations.
    * Remove reactions that:
      * Are elementally imbalanced for any element, except hydrogen;
      * Consume or produce compunds that (i) do not include a SMILES string[^3] or (ii) include an n-subunit polymer with undefined molecular formulas. Metabolites with arbitrary, ‘‘R’’ groups were retained as long as ‘‘R’’ groups were balanced in the reaction equations.
    <br>

    > **Expected Result**: Elementally balanced network that consists of 6880 reactions and 5944 metabolites (on Tables S1A and S1B). This network is referenced as: 
      >* "full KEGG network"
      >* "KEGG network"
      >* "Aerobic Network"

    > **Achieved Result:** This part of the experiment was skipped because I don't have the know-how of the area to replicate it and it does not seem to use complex networks (yet).
    > Due to the above reasons, I deemed that experiment out of the scope of this discipline and used took the *Expected Result* given as correct to use in the next experiments.

[^1]: KEGG: Kyoto Encyclopedia of Genes and Genomes
[^2]: Stoichiometric matrix:
[^3]: SMILES String: 

<!--
- Essa parte do experimento foi pulada pelo fato de necessitar conhecimento específico da área que eu não faço ideia como fazer. De qq jeito aprendi coisas interessantes como
Stoichometric Matrix:
Smiles String:
 Note that due to the filtering of KEGG reactions described above, essential for an accurate accounting of atoms, the KEGG networks used throughout the manuscript are depleted in enzymes that catalyze reactions that are chemically unbalanced (e.g., fatty acid elongation reactions, lysine biosynthesis), and in enzymes with no assigned KEGG reaction, like arsenate reductase (EC 1.20.4.4) and ketol-acidreductoi-somerase (EC 1.1.1.382). We expect that the accuracy of future analyses will increase with further improvement of KEGG and other
metabolic databases, which will better reflect the collection of biosphere-level metabolism.
-->
---
2. Apply the network expansion algorithm on the KEGG network using the following metabolites: 

    | Seed metabolites | 
    |:----------------:|
    | H~2~O |
    | CO~2~ (HCO~3~^-^) |
    | H~2~S |
    | NH~3~ (Ammonia) |
    | N~2~ |
    | Formate |
    | Acetate |
    * Generally assume all reactions to be reversible (by representing each reaction twice in both forward and backward directions). 
      * The only exception is the set of reactions that involve molecular oxygen, which are not allowed to proceed in the oxygen-producing direction, in order to best mimic the conditions of the biosphere prior to the great oxidation.

    > **Expected Results**: Figure 1A, written on tables S2A and S2B.
    ![The San Juan Mountains are beautiful!](assets/gr1_lrg.jpg "San Juan Mountains")
    *A single track trail outside of Albuquerque, New Mexico.*
     
    > **Achieved Results:** I used the run_network_expansion.m program, located in:  
      ```
      P3/assets/networkExpansion/examples/
      ```
    > MATLAB 2015a (or an updated version) is a very paid program I don't legally have access to. 
    > Because of that I used GNU Octave to run the algorithm and all subsequent experiment steps using MATLAB. The programs don't have 1:1 compatibility between each other, but GNU Octave uses a similar language and is readily available on almost any plataform for free.
    > *run_network_expansion.m* outputs two cell vectors, *rxns* (for the reactions) and *mets* (for the molecules). The outputs were saved with the command *save*, but any attempt to save the output as a csv or any other format readable by other programs resulted in failure.
    > My solution (*gambiarra*) for that was opening the variables in the Variable Editor by right-clicking on them, copying and pasting the values in a spreadsheet program and saving that as csv.
    > Now we can (finally) compare my results with the paper's. For my ease, each sheet on *mmc2.xlxs* was split in 3 csv files named *mmc2_SHEETNAME.csv*
    > I wrote a bash script that stripped everything (molecule names, reaction results, and the header) from the given tables so I could use the *diff* command-line tool to compare my results with the paper's'.
    > I'm happy to report that the results are the same! As an extra precaution, I checked if the example script also does what the paper reported and it seems ok. However, I might not be the best person to report that part since my knowledge with MATLAB script is limited.

    > Now we will try to show the network. One of the files provided in the NetWorkExpansions package seems to provide the (tabela de reacoes) para a full KEGG network. Eu inferi que pegando as reações e as moléculas que recebemos a gente consegue alguma coisa
    nenhum programa de leitura de csv queria ler o network.S pra eu poder juntar e montar um script no python. acabei precisando de ajuda de um amigo meu que tem a versao paga do excel nessa parte. obg thales.
    agora finalmente temos algo q parece uma edgelist??? que a gente pode tentar usar??? yey. essa parte ficou muito nebulosa no paper, talvez alguem da area apanhe menos???

    > **TODO:** final pq eu acho q nao vai dar mais pra fazer muita coisa: script python pra tentar mostrar a rede, mas principalmente, terminar esse report. e organizar os arquivos;
---

1. While the above constraints on oxygen-involving reactions can be used to study the growth of metabolism through the network expansion algorithm, they cannot easily used for imposing pre-oxic conditions in enrichment analyses that use sets of KEGG reactions andenzymes. For establishing the uniqueness of some properties of the phosphate-free network, we:
   * Perform tests of statistical significance for enrichment of these properties relative to both the full KEGG network (aerobic) and the network accessible without oxygen (anaerobic network). 
     * The comparisons with the anaerobic network were performed in order to ensure that statistical enrichment tests were not biased by including reactions and enzymes likely added to the global metabolic network after oxygen accumulated in the atmosphere. 
   * Generate the anaerobic network by removing subsets of reactions and metabolites from the global metabolic network reachable only through reactions that utilize molecular oxygen, resulting in a modified biosphere-level metabolic network. 
     * Remove all reactions that utilize oxygen.
     * Convert the stoichiometric matrix into a bipartite undirected graph, where nodes were either reactions or metabolites. In this bipartite graph, an edge exists between a reaction and a metabolite if that reaction either consumes or produces that
     * Input the resulting graph into the python package NetworkX ([https://networkx.github.io/](https://networkx.github.io/)), and all connected components were detected. In our specific analysis, this algorithm identified a single major connected component that contained the majority of metabolic reactions.
  <br>
   > **Expected results**: Tables S1A and S1B, containing 5,651 reactions and 5,252 metabolites, is provided in the Tables S1A and S1B [sic].
    >> *NOTE:* I believe the authors made a mistake during the writing of this section. As mentioned before, Tables S1A and S2A contents are the full KEGG network containing 6880 balanced reactions (S1A) and 5944 metabolites (S1B). I rechecked all other tables provided, and none of them seem to contain 5651 reactions and 5252 metabolites.
    
    > **Achieved results**: TODO?

---

4. Reduced carbon is an essential component of metabolism, requiring either an autotrophic carbon fixation process or the hetero-trophic carbon assimilation of abiotically reduced carbon. We tested two scenarios: 
      * (i) an autotrophic origin of metabolism from carbon dioxide and hydrogen gas and 
      * (ii) a heterotrophic origin of metabolism from formate and acetate. 
 We did not see significant growth from scenario (i), indicating that a reduced form of carbon is required. Acetate and formate were chosen based on previous
work suggesting that early forms of abiotically fixed carbon may have existed in the form of simple carboxylic acids. These acids could have been in principle synthesized at hydrothermal vents from hydrogen and carbon dioxide using the processes of serpentinization (Lang et al., 2010; Martin and Russell, 2007; Russell et al., 2010), or via a primitive variant of a modern carbon fixation pathway such as the Wood-Ljungdahl pathway (Fuchs, 2011; Sousa and Martin, 2014; Sousa et al., 2013; Weiss et al., 2016). We explored variations to this seed set in two ways. First, we performed a Monte Carlo permutation test on the seed set (see Figure S1) and second, we varied the identity of the carbon sources (see Figure S2).

To identify potential thermodynamic barriers, we performed network expansion without unidirectional reactions (see Network
Expansion Algorithm section) above a predefined free energy threshold, t. In this variant of network expansion, reaction r was
0o
removed if DG0o
r > t, for varying levels of t. We obtained estimates for DGr from eQuilibrator (Flamholz et al., 2012), which uses
the component contribution method to estimate free energies of formation of metabolites based on the group decomposition of
compounds (Noor et al., 2013). We obtained estimates of DG0o
r at various pH values, ranging from pH 5 to pH 9 in increments of
0.5, while assuming a constant ionic strength of 0.1 M and temperature of 298.15 K. We performed network expansion at
thresholds varying from 0 to 60 kJ/mol in 1 kJ/mol increments. Final network sizes in all scenarios were insensitive to the choice
of pH.
Over one third of all KEGG reactions did not have estimates for DG0o
r , due to the large set of metabolites with no estimate for the free
energy of formation. We accounted for this by either assuming (i) all reactions with unknown DG0o
r were feasible regardless of the
cutoff or (ii) reactions with no estimate for DG0o
r were infeasible, and subsequently removed altogether. The qualitative results pre-
sented in Figure 3 of the main text are unaffected by the treatment of these reactions.

```
Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.
(this was after 1, presumidademente)
Network expansion was performed with a seed set of eight com-
pounds thought to have been available in prebiotic environ-
ments, notably lacking phosphate (Figure 1A, STAR Methods)
(Cody et al., 2000; Lang et al., 2010; Martin and Russell, 2007;
Russell et al., 2010). Importantly, the set of seed molecules we
defined contains simple carboxylic acids in the form of acetate
and formate, which could be provided by either an abiotic mech-
anism or a primitive pathway for carbon fixation (e.g., a primitive
variant of the Wood-Ljungdahl pathway [Sousa and Martin,
2014; Sousa et al., 2013; Weiss et al., 2016] or the reductive
TCA cycle [Morowitz et al., 2000; Smith and Morowitz, 2004;
Wächtershäuser, 1990], see also Discussion). The resulting
scope of this seed set consists of a fully connected network of
315 reactions and 260 metabolites (Figure 1A; Tables S2A and
S2B), the composition of which is robust to variations of the
seed set compounds (Figures S1 and S2). Although this network
requires the addition of catalytically accessible carbon, nitrogen
and sulfur sources (Figure S1), acetate and formate were substi-
tutable by several alternative carboxylic acids like pyruvate
(Figure S2).
```

| REAGENT or RESOURCE | SOURCE | IDENTIFIER |
| :-----------:|:--------:| :--------: |
| Database KEGG | (Kanehisa and Goto, 2000) | http://www.genome.jp/kegg/kegg1.html |
| LUCApedia | (Goldman et al., 2013) | http://eeb.princeton.edu/lucapedia/ |
| MIPS | (Hemavathi et al., 2009) | http://dicsoft2.physics.iisc.ernet.in/cgi-bin/mips/query.pl | 
| eQuilibrator | (Flamholz et al., 2012) | http://equilibrator.weizmann.ac.il/ |
| MATLAB 2015a | Mathworks | https://www.mathworks.com/
| Python v. 2.7.13| Python | https://www.python.org/
| Inkscape 0.91| Inkscape | https://inkscape.org/
| NetworkX 1.11| Network X| https://networkx.github.io/
|D3.js| Mike Bostock| https://d3js.org/
|Webweb.js 3.2| Daniel B. Larremore| http://danlarremore.com/webweb/|
|Network expansion algorithm|(Ebenhöh et al., 2004)|https://github.com/segrelab/networkExpansion

We constructed a stoichiometric matrix from the KEGG reaction database using reaction equations. Reactions
were removed if they either consumed or produced compounds that (i) did not include a SMILES string or (ii) included an n-subunit
polymer with undefined molecular formulas.

The final list of chemical reactions
is provided in Tables S1A and S1B.

Second,
the stoichiometric matrix was converted into a bipartite undirected graph, where nodes were either reactions or metabolites. In this
bipartite graph, an edge exists between a reaction and a metabolite if that reaction either consumes or produces that metabolite.