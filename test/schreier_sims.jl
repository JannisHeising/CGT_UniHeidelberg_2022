@testset "Schreier-Sims algorithm" begin
    order(::Type{I}, sc::CGT.StabilizerChain) where I<:Integer =
        prod(I∘length, CGT.transversals(sc))
    order(sc::CGT.StabilizerChain) = order(BigInt, sc)

    for group_order in 2:30
        for S in SmallPermGroups[group_order]
            sc = CGT.schreier_sims(S) # defaults to Transversal
            @test order(Int, sc) == group_order
        end
    end

    for group_order in 2:30
        for S in SmallPermGroups[group_order]
            STree_t = CGT.SchreierTree{Int, eltype(S), typeof(^)}
            sc_tree = CGT.schreier_sims(STree_t, S)
            @test order(Int, sc_tree) == group_order
        end
    end
end
