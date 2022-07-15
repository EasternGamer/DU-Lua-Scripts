if not init then
    l1 = 0
    l2 = 0
    rr = 6
    rx, ry = getResolution()
    cx1, cy1 = rx/rr, ry/rr
    sx, sy = rr, (rr + 1)
    lp = 0
    m1 = {}
    m2 = {}
    m3 = {}
    is = ""
    local lm1, lm2, lm3 = m1, m2, m3
    for ix=1,cx1 do
        local lm1ix = {}
        lm1[ix] = lm1ix
        for iy=1,cy1 do
            lm1ix[iy] = 0
        end
    end
    for ix2=1,cx1 do
        local lm2ix = {}
        lm2[ix2] = lm2ix
        for iy2=1,cy1 do
            lm2ix[iy2] = 0
        end
    end
    for ix3=1,cx1 do
        local lm3ix = {}
        lm3[ix3] = lm3ix
        for iy3=1,cy1 do
            lm3ix[iy3] = 0
        end
    end
    init = true
end

dl1 = createLayer()

function DrawAllPixelsL1()
    -- Localize
    local lm1,lm2,lm3,lrr,lsy,lcx1 = m1,m2,m3, rr, sy, cx1
    local setNextFillColor, addBox = setNextFillColor, addBox -- These are globals, so also localize
    
    if l2 == 1 then
        for by=1,cy1 do
            local m1bx, m2bx, m3bx = lm1[bx], lm2[bx], lm3[bx]
            for bx=1,lcx1 do
                setNextFillColor(dl1, (m1bx[by]/255), (m2bx[by]/255), (m3bx[by]/255), 1)
                addBox(dl1, (bx - 1)*lrr, (by - 1)*lsy, lrr, lsy)
            end
        end
    end
end

function LoadLines()
    -- Localize
    local byte = string.byte
    local lm1,lm2,lm3 = m1,m2,m3
    local lis = is
    if l1 < cy1 then
        if l2 == 0 then
            for ix4=1,cx1 do
                local m1ix4,m2ix4,m3ix4 = lm1[ix4],lm2[ix4],lm3[ix4]
                cl = l1 + 1
                for ch=1,3 do
                    lp = lp + 1
                    local tmp = byte(lis, lp)
                    if tmp ~= nil then
                        if ch == 1 then
                            m1ix4[cl] = (tmp - 33)*2.8
                        elseif ch == 2 then
                            m2ix4[cl] = (tmp - 33)*2.8
                        elseif ch == 3 then
                            m3ix4[cl] = (tmp - 33)*2.8
                        end
                    end
                end
            end
            l1 = l1 + 1
            requestAnimationFrame(1)
        end
    end
    if l1 > (cy1 - 10) then
        l2 = 1
    end
end

LoadLines()
DrawAllPixelsL1()
