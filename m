Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA16306
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 10:34:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA24223
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 15:33:07 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA24219 for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 15:33:06 GMT
Date: Tue, 19 Mar 2002 10:33:54 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: file_contexts
In-Reply-To: <Pine.GSO.4.33.0203190852330.2799-100000@raven>
Message-ID: <Pine.GSO.4.33.0203191030001.10143-101000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1016552034=:10143"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1016552034=:10143
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 19 Mar 2002, Stephen Smalley wrote:

> I'm uneasy about the lack of any error checking in that case (e.g. someone
> makes a typo in file_contexts).  David Wheeler suggested a while back that
> we partition file_contexts into a collection of files, like the policy,
> that are merged together during the build, with each file corresponding to
> one of the domain .te files.  He suggested the convention of a foo.fc file
> (fc == file context) for each foo.te file.  The challenge in that case is
> ensuring that the ordering dependencies of file_contexts are preserved.

Try expanding the attached archive relative to your selinux directory.
This is a rough cut at partitioning file_contexts.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-851401618-1016552034=:10143
Content-Type: APPLICATION/octet-stream; name="setfiles.tgz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0203191033540.10143@raven>
Content-Description: 
Content-Disposition: attachment; filename="setfiles.tgz"

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
/zX7PzohwD8qvLAAQCv2gPGQ8srXrZRoLeA61K8TsHeupxPzPw4GF23lzl2x
94Q0+HdPuPWLUxP+J5Ns/W+Ge8HHMxAw+O+CEP9uesSzG1fNAMiwdMUcfz9+
THRnTWLQwWJ84gXbilsGZJiB7XlIi//otA6gTfifT3L9/5yv/01n5v2/ExL4
J5FNhDcmk+d02wMH/qk0BVHmcJljHwCzMAxHSfHj+1rI5G/MqcuZ5pw++PPo
NfUGjhsdKclvPbhklFaMPA4Ez63QI6mM/9DeWa5/yqsAG/2/p7n+fzEV7/+m
/++EAP9S4apjlz/1AJOBxe5dPb2MKIuDSHsXQIOkuDahvViMZ1m3zGP2ApEW
rVnq3HrpijT4Z7Tj/R8LvPNT4n8+4vP/45lZ/+uE+uTVD+9evsicv/npqI5F
93ixm7hNhLcI+ItozJrWBDjzSt43VzzRWkQkTymvEC8fyZ0KDmkUJDGtTTcP
+UPxKw8+HbpOtp8kHnpJHNSXuk6chW5TpZ3F8pTwfwWvYx3P/41nixz+l2b+
r0PqE65w2bHy79pelYeUu9SWAucupaEqKuGfz8Z07f+b+f/Mx2L/58Ks/3VC
fcIVLi93rJylM3N0D5R0+I+C2IpPeAT4Mee/zSdTfv7bzPT/nRDHv1B4rltP
n1XYAhFo7MH9pzL+T779r3n9P3f+yxznAsfTxdTM/3dCgP9QHv8cRq4fV9zB
KsMKY3+v4tB3T3fku72j9lWoPfNdBmkOXfLqjnvHZNLzk7LL8HhO0Uup4vCl
NNwYLiQN/k969iNS8/p/Dv8z4f9v5v+7IcR/Nvk3yE6BgnZQge6ogG7B+8sR
vJF+40CO+dyV8geiEv7xgg9oDl36/y8W2frffD7h579Nzft/J9Qn4kaX/Okv
/OJscc9L5alO6h4YdVE3znTLZzUXKkoh+aAoJu/xlb/Q1U8zU65icGiYHQ1C
Q3isPxqKBx0csBI40NbX+svUVeDBeqPPqlIQQTr2ATSs2NWOeHRC0b4qCR7y
uUyjBv8nPfsdqbH/H+XW/+ZLsf/fvP93Qoh/fva7gAZ8JY+bd/4Ujn/noomQ
bXeEjjk9/ndDJfz71p52vP43mefG/wvh/z8z+/87oT7hChdv3fxrfoFe1x1x
prTfx7GCaDL4hLQVS+cF+ONGMWMqPheV8U9jZlvhKW8AbfT/zZ3/Mxfn/yzM
/Q/dUJ8QpXHo/v/tep7VG0ZBEA8/DlRA7cnueJqdYlxFNwhuKS6jO1Z6F+zp
kN/yfJB+xUHqleLF9NtJq1kK9VhrkpTI4dSGTLCNzLnVnpIO//gq2KX/73iR
jf8X/Pyf2dLc/9YN9RH+N0F0VTr+1dX72Kv2UXx7tSK8oL2VwLlLbChPGvzf
RIF30gvAjzn/YzEW839jM/7vhBD/XOF5t1VGPddPbmVPyIP1yOZBBtj3mMr4
Z3bn5/8uFjn8i/N/Rwb/nRDgHxSefyFnFdcsYICB+kOjEv5Di7Gb01qARv+f
UQ7/4vyf6dyc/9sJ9QkTGq/q/2Ww1pWGh2i2vRTk7R3b/RbpjfamtqL0uWvx
/lIZ//Ae13n/n3v/n05N/98h9QkqXKzh4Teid/+DEIO1h0hl/AdRvLfCc93/
vJiJ+x+N/283BPgXCpcTefKX3gqIMGMIHhCV8R92fv/PeDbK4X8m7v8x+O+E
AP9h4f4f/KlHf5jz6+f7BcIKMxGGKwh3bWqMxO+eyvhP9ift/B8dOf6fi/H/
1Pj/dUKAf1C46vyTioO1MMB0+w+RSviP+Fbvkw4Bmv1/s/2/i8VcrP8Z/59O
qE+kwvm5PzH1SqcBDySD1jVdBOnO6h3IuFqInbsO/shUxn/Y+frfOOf/u1jK
+T9z/lcn1Cdvf3ghz/tSnj/QBHD7jX4zSmhr4J5K1Aucu7CGSqTBf+f3f00m
mf/vciT2/8/M+l8nBP0/3v+F3v+4Fw9+VPvr4iG3wLQCJrXtB77qVwyi7Bow
EXmwRebwasv0doJHHmxl5Oeulj8MlfHPdt3f/z3O4X9u7v/ukAD/qPCDET88
0oIanpu+/EFRGf+JvzrxHSDN/r+Z/89yLM7/Xhr//04I8C8VXuWCo8K1BkGG
GaNwX6mEf1B9EJ72AIDm+z+y+f/llK//Tc35n91Qn7zjCidPPWtNPeqo/UCu
v32mPRW8yk5sPAis3/cv2laNy584KuzgGIFPjSc8UTzM3odOfTzIcT9toAb/
vrO3TnoAUCP+l9n8/3LGz/9fGP/fbqhPlMLFXn7Lcy1WcbMGhK9kuNr6L38O
nHVbCUxKTTFUSCBLYXpRZVG7iViGaY4PzCelOYQEhdIDBHNSvyQ0qdnzLMKL
kji7kQKHaYdKaT7VRMfvw1KU8e8HUdfn/0xz/f9MnP8zMf4/nRD0/9+/efs+
DzZsANoWjAGFC7z4k8r99ZI/LswBthH5/aDj4VMZ/0Fy2tX/Fuf/jXP4F/f/
Tcz9n90Q9P+ocDGbbyV79/ZyD2/0e8trHDyjXMEhEIRpNLhodwaYEE/9BHkE
Dgv14m0jsBLHDX5LDvau41ZkoTkCNIkfB7wSI7t9BPKypPPov4z/XxK36/O/
Zrnxv7j/bzIy/n+dEOAfFZ7v//G3/qpeDCmMs23L3lEhUXPMDxfjrIWRQGU6
aoQsBM1I4HNSGf/dr//N5rn+X/r/TMz8XycE+AeFy+E82+Hx+XvK2vRduBZ4
Re/SdwEQhr/VLmAxPtee5lcr5DCLC35SitERwpmpw3VOVcSq7Ep790CtkA7/
Xfv/5Pz/pyN+/+d0Yfz/uyGO/+wIO4Z79fVIuJ/z24bqqYz/5NTwb8b/fJbh
f8zxP1sY/99OCPCfiJd/ljzWQz8xyH+4VMb/HTv1DcDN5/8sc/hfiv3/pv/v
hPpEKlz6/stfeksgwg6u03B9t7VENvJWyTTL4LQcPKi43+PaLBb8JirhP7Y7
3/+fO/9vOpqI/f8j8/7fCfUJKjyHTPypxRoGmJHAQ6MS/hNQexjTU14C2Hz/
7zjDP7//E4b/ZvzfCfWJUnjOBqhHOjOgwowpeBBUwv+t0/n+v8U8h//lROz/
M/4/nVCffCDfuCz0rDvyneVbW2UI0A78eLu9+snZNy8GQKMprAtKwfxVQvXC
YhTPE66Rr5Ptk//27WC/p35M3A25CxJiRRR3N/h4rKHllws66PXT1cgP30aU
/sdCvzcxl8ow3ofDwYfx+DLx3dtyAfXCIJQTHl16gX3VysUgE/5M+i/jf3PK
qz84Ne//z+b/x2r+3/T/nVCfgMJ7omFuAj/ONWstEjZMtkeOVcDB2wU3FRBQ
xW8GCr9jKuOf0ej6pMP/Zv//7P4PwL+Y/zP7/7sh7P+FxqUH3TbcWuj/qwEz
hB067EVujS8/hOb4NR2n9v0Cb+WSjVCZmny3qU1JJ1S0Tx9uIisM9a80SvDw
vIL6MYEU+n258x9NJfzfhesTH//VYv//KMP/lO//mU6M/28n1CdC4XI2X/zQ
YkwEmd7ckCFDhgwZuv/0/w/wzRoAGAEA
---559023410-851401618-1016552034=:10143--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
