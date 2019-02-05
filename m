Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283CFC282D7
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C49217F9
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBEK0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:11382 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfBEK0k (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 5 Feb 2019 05:26:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 02:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="gz'50?scan'50,208,50";a="144294182"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2019 02:26:36 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gqxw4-000BBP-2C; Tue, 05 Feb 2019 18:26:36 +0800
Date:   Tue, 5 Feb 2019 18:25:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     kbuild-all@01.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v4 3/5] LSM: add new hook for kernfs node initialization
Message-ID: <201902051844.3yBuDPaF%fengguang.wu@intel.com>
References: <20190205085915.5183-4-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20190205085915.5183-4-omosnace@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ondrej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on v5.0-rc4 next-20190205]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ondrej-Mosnacek/Allow-initializing-the-kernfs-node-s-secctx-based-on-its-parent/20190205-171434
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=sparc 

All errors (new ones prefixed by >>):

   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:50,
                    from include/linux/etherdevice.h:26,
                    from arch/sparc/kernel/idprom.c:13:
   include/linux/security.h:796:1: error: expected identifier or '(' before '{' token
    {
    ^
>> include/linux/security.h:792:19: error: 'security_kernfs_init_security' declared 'static' but never defined [-Werror=unused-function]
    static inline int security_kernfs_init_security(
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +792 include/linux/security.h

   791	
 > 792	static inline int security_kernfs_init_security(
   793			const struct qstr *qstr, const struct iattr *dir_iattr,
   794			struct simple_xattrs *dir_secattr, const struct iattr *iattr,
   795			struct simple_xattrs *secattr);
 > 796	{
   797		return 0;
   798	}
   799	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICG1jWVwAAy5jb25maWcAjDxrb9u4st/PrxC6wEULnHb9SNLkXuQDTVE215KokJQf/SKk
ids1NrFzbGcf//4OKdkm5aF9Ftsm4gzJIec9JPvLv36JyPtu/fq4Wz49vrz8E/1crBabx93i
OfqxfFn8XxSLKBc6YjHXXwA5Xa7e//51+/a4eYquv3S+dD5vnnrReLFZLV4iul79WP58h+7L
9epfv/wL/v8FGl/fYKTN/0a21+cXM8Lnn09P0cchpZ+i2y+9Lx3ApCJP+LCitOKqAsj9P/sm
+KgmTCou8vvbTq/TOeCmJB8eQB1niBFRFVFZNRRaHAfi8qGaCjmGFkva0K71Jdoudu9vRxIG
UoxZXom8Ulnh9M65rlg+qYgcVinPuL7v98wCm1lFVvCUVZopHS230Wq9MwPve6eCknRP6ocP
WHNFSpfaQcnTuFIk1Q5+zBJSproaCaVzkrH7Dx9X69Xi0wFBTYlDs5qrCS/oSYP5SXV6bC+E
4rMqeyhZyfDWky5UCqWqjGVCziuiNaGjI7BULOUD+D7sDylBhNyNsSwAlkTb9+/bf7a7xeuR
BUOWM8mp5ZgaiakjDA2Ews6N2YTlWu3ZqZevi80WG270rSqgl4g5dUnKhYHwOGUuXT4YhYz4
cFRJpirNM+Adwu5CMpYVGsbImTvlvn0i0jLXRM7R8Rusk92iRfmrftz+Ee1gqdHj6jna7h53
2+jx6Wn9vtotVz+Pa9acjivoUBFKBczF86FLyEDFMI2gDHgIGBqlQxM1VppohVOp+AmFkpaR
OmUAzD6vAOZSAJ8VmwFfMHVRNbLbXbX683H9C6psRn0SEB2e6Pvu1ZErPNdj0KmEtXH6jiYP
pSgLjKtG41RBYNMcSdeqyp1vo132+zAe6IKEJkxKeOz1zZlu9aUjRseFALKNvGkhcVFVgBdb
+2Fpx3HmKlFgQEC4KNEsRpEkS8kcoXSQjqHrxBpBGftGUZIMBlailJQ5pkrG1fAbd4wRNAyg
oee1pN8y4jXMvrXgovV95ZggWokCdJB/Y1UipFFy+JGRnHpK10ZT8Asmcy0DR0B5YYEidtk9
IhNWlTzu3nhGFTqCMFMG00An2BLqmNFBkbjkBIW+NWwGhp4b4XFmGjKdgVLaKUmaejQYJrSb
kxHJwb61TXptt5xWqxiu7xkeP1iagHeT7oKIgp0svYlKzWatT5BvZ5RCePTyYU7SxBElS5Pb
YK2726BG4G0c/nBHNEg84YrtN8BZGnQZECm5u41jgzLPPE3bt1XwE+HNAWzXbtRE84knZcDl
/fSoahlOWued4KoHdLI49vXS2tQmuioWmx/rzevj6mkRsT8XK7D7BDwANZYf/N7R2E6yeusq
a/c9PpsghWiIcBxeq5R4jlql5QDTDkCDzZRDtg9C/E4ATcBtpVyBqQKhE1nAtYmEp+CMUOjN
1YCj7qAg0o1izGffMSTwOTJk1Z/3HyDQ/L2OUn99skHptv7q96rnxY+66YPX2fjCamzEHCK4
mXa2DFzowLAnjznJnSlNPGP7OrKWOU7LBAmevH6DWKCKXXN3CHMU8QHFUJMBBJMpMBKEuV8L
QrFZPy222/Um2v3zVvv/H4vH3ftmsa3Dg2Z3MtwBQKzT7XSQ3QVA77rjshNa+j5qaxR8mHsY
5mCrp4plhxWqgucmYjtd+2jKYKP0KQAUiQ8keCpgLDilFrMzMq9tMbjbJHZkg4HZNO6tolkx
oyPHjoHppww6ziwnhIzBJIDf3+9amVdF5sm0kTJgQYwJJJBIUtCnXImUYb1EfqLIg/dttH4z
ydE2+lhQHi12T18+HRVXDUpHV80XHRHHbEEXav5ycIBoUbAcpBd88P1rPU+23D41mZqlJnre
LP/0TITbD6zoqxvyxWCoQQlUt9OrSqplerKOfd5ktGy5WzwZCfz8vHhbrJ7BLO2X6OR0kqhR
y4VY3onaGrSbLYOtDx0JgYgMCLiN2is9kozELcmYEjB9JgqDpYOp3udcbtBg0kOIayGykkIz
CmHVPlDfK7KIyxTie7DZ1v0Ze98iks1A/dsEiDiupDbOjVDtzSpMLseHqlSw7fFJexvdWB3I
P1iScMqNLU8Sz1tJY+tK016mCIOomHz+/riFLP6P2nm8bdaQz3sJQpGWQ57bTBKybSdu0xB5
gA10ox7r9FRmQotOa49cquqmRtFSQTDNaXDK3MCDnWswaoAAr+EpnpY040C6cMirAx55j8lx
Z9SAjc+E2BufTEueAbEgJ3E1NvEBGjt7hi8dxCRxthYia0UVB5ZCnq08r7qPugcKp9CBg608
iwLxHRtKrvGEc49lDCO+6waDZjF4blYrlgyiTQd4NmlXCvskCnIqssXjZrc0diPS4Ns8fwbT
aW7jagjyTGyPipWKhTqi+iYSaWYJx5oNjdlDY2TrCoWI1NPvi+f3F8+CAhIXddoVgwkw++KY
jyNwPB/YyPOYtjaAQfKALAO8pNlh4y6tDkAOz+WDm29ZuLE6DfwcDO07BSlgoc4usOltd4H9
vXh63z1+f1nYumBkI9Gdsx8DnieZNsbSSxx8o2/Dq7gE872vYxnjOgKCvSi1GUtRyQt90pxx
RcFjOUOaEfeEZovX9eafKHtcPf5cvKLuKIH4wAvMTENl8jyTLECA4BbQihTMfKHtfoBRVvdX
x5khlm6Z7YwPIWLxJQrMtJ+OjlWGcH6/IxnMD+MYYY/l/VXn7uZYHQCxgdTROoexF6rQlIFi
EBAsVPMSKXJtKoMolGYEbf9WCIEbzm+DErcS36yPEBQFWpddEEggjG8fh3IAWKFZYLjuNCyL
asByOsqIHGNVGuYIjRoPwFVrlluHsZeSfLH7a735A/zhqXgAU8fMM8N1SwXxP1ZsKnM+88o9
8H2Ce3QYKeYiZol05NF8gdMailaTrQU4sZptNIYd8kqKc96iqHIAeX/KKW78LU4tuecGAX5A
bsdpiH4Tcwm3YG6qWWM2dylumrDZDnbI33te1HUQShTuVQBh7xYqKSBwkdioRVXkbi3fflfx
iBatyUzzQAiNq0qDIInE4WZ9vODngENjAiFJmeGSa6bQZZ6z1Esq5jnYGzHmDFeJuuNE8yA0
EeU52HFajL2GKRUZud4CGpjyN69pq0SSBGI/XtPpi4lttAJ0WLcLQRtrkTUWG0xJrgohdRjj
/AADxtp9jfK2qaDFvtlfcBkXYWW3GJJML2AYKMiE0lLgGmpmh1+H5wKgAw4tB9zJh/d+ZQ+/
//D0/n359MEfPYuvFVpKB6m68VVkctPomTmmSAJqAkh1ydVYjCoOSsONEatXv8XI1au/RTf/
hWDd7CXrtUVIxoubYB9X8Fp04K0XRe/mguzdnApfa61HuN3opnZt44rwdreU3wUprk9YCG3V
jUT30oDzGKIsGxPpecFcwzlxNqa1z8ZOFyYtN7Ur3FDViHZZYbhiw5sqndbTXECDIACPNmAn
zVkvYNF2nHCCU4zmtvwMPi4rQnEJICc81aHEpzgDBOMaUxp0KYoG3I2MA1knSDoKgMAWbU97
gRkGksdDzA/bGoc1Toq4wtM0oYNNUpJXt51e9wEFx4xCb5y+lPYCCyIpzrtZ7xofihR4JlyM
RGj6m1RMCxJQLsaYWdP1VdB/2oQOXzINZOXAKGLzWRRsSnMTNeWajvCNVubwOxAeA0WQyo3D
Picr0nAUkSt8ypHCRduu31IaM3wxBiPtQ1qljM84h5VThdkw60Rn1aBU88o/RBo8eFGSOYH5
Dblk0ET70W6x9c/IzcjFWA9Z7hqzEckkiSHvR5OlgJgEah4kAdJlSFuTakyxXHDKJQML6p8E
J0Mjht2T1R0Aq8XieRvt1tH3RbRYmVz92eTpEVhIi+AUL5oWE9SbYujIVsXNseh95zjjlEMr
bpeSMQ/U1MyW3gXyTMLxcIGyYlSFClh5gm9eocBWh25umDAzwWGYX9lrq9KVTaKdkrMUQF59
oOjbQDYxWoZVosjc1o0bDLdjQngqJmiGYu0tbSR4n6bGiz+XT4sobpfvm4MP5yCg/eGcBB93
jHJmwhVQJHxHoVuGaqCBPJRcjlVrPFjkoAyk8YYIXQZsMQC5wC2BgRUSz2QsjCiOW9sRpG1p
abFO64vQ9rRe7Tbrl5fFxjkRqXXo8XlhzlUBa+GgmctEb2/rzc4rR8I2gpjEDAJxWz0PUppo
+LsbOEczCKb3/lQjhMSqmTkvnZ2sKF5slz9X08eNJTuia/hFHcg9LJqtnt/Wy1V7CeY8094r
QXdq+9dy9/Q7vmE+h6eN9dcstAJKZOCuCSl4y8wej5eWT43YR6JdoCnr0+0RSwv3UN9rBinR
o/sPv26/L1e//r7evb28/3RSHtBNnRUJluuCScxjknrHQZDo2LETLrMpgQTe3s3ba2my3Lz+
ZdjwsgYx2jiFxqk9BHGJZDPIGg7jmFOXo3HYY9cXhup1IASaAtvUVuud2qezMlDIKpZ8EohF
GwQ2kYEQvUYw1xibYSrJMrBaeCRq0Iia53SPXEgxwAJKyYZeZbX+NpXu/T6a49Fna/E8MYMf
uT2jw4uBeeBkJtNYciOc8rRIDLGZlox5jWMx+M1raJWkoMUY8dZFKfe4wlhZZPLmlAU74cnL
NDUfwYMTg5RgK6IxrMENX/bYxnYoFcNG8KLfm+GefI9cZgwLRPbgVIjimAi7rbZUbY8i72/b
cCrnhRZN35MpYzkIHzXZPbkAV7PbMyRL4lRUncaG2O4NBrMhkK25H8XP7K+JEmk8wemBHMUK
RMU0HjsfZriwIKlmp2Y+n2TMseunu2TgaBAEgMoPno63AxA9I/F173pWgVfAPRpYmmxuzoQC
2RXJdeDOjxoab0/xBErzJLOWDIWCk02FKsHkgk2ccBqwWaOigsgqkA9qDf0qRot+VbfhRAL/
g4567yxPbncfsSaQQAa8OO21DUJ9psaM+cFCjBoCghXIcRv4XZ/Obs4jzGZXOAYdfO12Tva9
vke9+PtxG/HVdrd5f7X3zLa/g3t7jnabx9XW0Bq9LFeL6BkEaflmfvVuH7FcCakgnld9Y91P
hicvu8XmMUqKIYl+7F3n8/qvlXGf0evanLRGHzeL/7wvNwugo0c/7eMZvtotXqIMtvl/os3i
xT5T2PohzxHFuJM6hNjDFIUE5LR5Igqk9TjQaL3dBYH0cfOMTRPEX78dbnGpHazAPar8SIXK
Pjnx/oG+w3BHFtMRLvDmfBSCBGruw1I8jLYoUqtZG8PNL3jsnVrC5wkrzb2FxpQ4fNgLgrnU
kAnvjockPDZvBdA786aDc3BnunuX4myLvaeXHA7yLAXN1PWtuI8gln/8O9o9vi3+HdH4M+iB
c8Xq4Ds8suhI1q24bu/BQqFPOw5jSszNKVlB7BgLLJQ7zDt0ex5aA9Ufuw/wu4lUAzUgi5KK
4TBUzLQIkCHmdfCGc1bv9X3b4iqodc1F74zKQBJ6yl4fg9u/LyAp837nMkrKB/DjDI4szkob
bNHUXrH0BN1CdKhca6HmhLC+cn2GQ7PhoF/jn0e6uoQ0yGe9MzgD1jsDbMSwP61m8J/VwPBM
oyJQ2rVQGONuFggk9whn+UGCuWANJvQ8eYTTr2cJMAh3FxDurs4hZJOzK8gmZXaGU/Z8DuTi
DIakWaCUauEMpu/h8IwNiTWgOZsOGV6GPOCk8EvgvP+Ac36lhe5fQuid176MSF08nNmuMlEj
elYcNReB1yyWhLnE60v1/KF4rHEts373rntmdl6cM2O5uTl2Fk5CpZ+aOs3OiKGaZ9d9egsK
i5+LWKQHsPCcVt3eLXYd20GBbXQdTAMhl+xOTPt313+fkWVD491XPK63GLmC1DMMnsZfu3dn
duGkuuhtUZm3biDUAUJ2wYgU2W2n0z0z6RmvKyCftpwnoXoEJIO40uEUaSKHTIfzn6RUHLlJ
bg6lom7/7ir6mECUPIU/n7BEIuGSmcMEfOwGWOVCYW++cqbBc3DvtVveEOvVMEQet+IMN2V0
JY89lCSFHDt8lhSo9ts7GCyQoWWEmqNHFDaZhSDQSwWKljAbrW/240wr8RGhvZrYHbJPYwO9
J6EyQZ5mgQN+cBqto8uayeZA5ZiUtWra8RISuOX3d5MkqbqeS5wL+6ePAoAuJr3Lc2YtdfBa
9anwbhxOIKMNGDA9L0bCX8npeCQmhWbec9ymyVRgZRIS2qFsbR8y9JD5Asp0t98N3bfad0oh
+OAw/cizKCmHlAx9Cup21cze+DyuhLKQ7zHIklRaYTVSd9CMfHOvkXogL3mBz9tutxusPhVG
dnwrvF9dmafNW0lkFlDVHAwdDnRfY7ntRoSElxYQnYaO9lPcChsAznwDCW3rJf6WUkjvJkPd
UuWD21v0OZPTeSAFiVsKMLjC/d6AZuZEJ3AFHiJ5PMUMyYvmQ5H3g4MFnOccoousXXRyO2J5
rL9gc8LlrTcn5/s0R2Lekw5CsaeEXqcJLzNUluiIpco+8XQyY9tUaVxwDmB8vw5gnHFH8CS5
QDTETR5dbW1HugAveO7J35BlEEocrC5KU9wCnA4c+za0vjGZ+jdQkV7tk+k47eFnD2AjYmMj
zo9nHt0x7xY0JKUXaWff6IgXKPNHXmA3KvCHi26HkkwZR8fit73r2QwH5dpP/lkoZmftR4/H
isAQz0GgfRK4HjkLdQFA4F7cVScAGOJ247fsAssgOZsw/4JANslC117UeBj4lwfGc8y1uBPB
LCQXnnRk6eyqCqWw6ew6HBADVE3PgpPpBXo4lT7Tx+r29ho3KTUIhsVvu4zVt9vbq1AZtTWp
aKTdMRu0d/vbTUDgcjrrXQEUB8OWfr3qX3B6dlYFdgYVfsieuccU+O52AnxOGEnzC9PlRDeT
He1R3YTHu+q2f9u7oNfwq/mXW7zwSvUCUjqZoXcZ/eGkyEWGxzy5TzuvYDxQlBwiysyc/7f9
+ukIt/27jm+Pe+PL0pFPeMw952BfQcYXQ10x9igGfHHBETVvWVg+5Ln/eHMEISdIKLqxc2Yu
HST8QlBfVxvcQR9S0g9V7B7SYNTzkAbEECabsbwK9kOvxrsUluZkJPMiuQdKvoJxbx9WOXCR
gYcL3DOW2UWhkLG3J/Kmc3VB6iUzeYLnoW8h3Q/UpA1IC1wl5G335u7SZLmpOqIaIc1FU4mC
FMkgOPBeRCjjv9qJCNKTsQd8SJFC6gd//Bf1gZoAtFeJYecFqVQ8Jb79oHe9Tr97qZd/usHV
Xaicx1X37gJDVaY8GWAFp8HyIODedbuB0N4Ary5ZTSUo2Ezv37Fwodo6Bm95OgMB/y9YVzo5
6YgUxTwDUT1eDQH4AAbyGh6YV3wEmWF4HYcSpSAkxhWflxcom+eigMTHi2qntJql/8/YlTU3
bjPbv6LKU1J1J2Otlh7mAQQpERY3k6AWv7AUWzN2xbZcklxf5t9fNEBSXLopVyVxhD4EQexo
dJ9eNIZu+1npuKmszaQm5cpT9SdExiO1NWGU0qihh2rnt6ovAepnFrtqlsaXOiVV+zfVzpLQ
3RXZrsVDw4DJpGTrMdUDSwBFAjK3bbyZ1A6HmEVha5kZfSKupnC3lAmw2bHBXmw2GxPOqlFE
3BM0zkJaNQY3+t9OL0/7XppY5fUxoPb7p9xqGiSF4Th72n2c90dMw7puNKux7NDW1731CxhQ
/9l2Nv0LrLRP+33v/FygEPvKNaXS9Deg0aFVqIiV8eW8kNh4rsHKb32HeP/4PJMX/CKI0prv
k/qZzefgRN00XjcyMN6n7P8NItHUAkuf8FQ2IJ/JWGyaIF3g9LQ/vgIvzgtwIv3cNUyc8udD
oGuol6MGuAu3YKb3Vk91VmgiUGW9VauLMto2DyydrRWyKoVakZIxubTs6lRZSrzlkjAdKyGB
s5aE9rjEgFsJnJzwa60SlshwzdYoDdwFkwZUYUPVMLiGpYRsZON72u1zqR/9M4uSwaXuyyQ1
20YJAs2srY0lw/5U/Y0iTKhWEBaBgzMm5FtNAoKJtDe7Ng+rnaZKuaOmCFAs43Pb5fUOKCOI
jW3lbWHK3SXKknUBzYFWNFdm14SGt6jabiZdreSeo7PueL3F/TF13WcQq0Rt9hlxA2YKUFRy
BhMsPcjVGATXUVwpZSDazZBwCjcA+J5ErR2EpiHvbiKhdvZihFvIubvjkzZbE9/DXtNABo6r
l65qyKqA4aqkqzKI37UHMjG9GVV6uElU/9X+pdXtkxaoE6VqZqQLGLFaSM14aTwWszW+SGpp
fjXRyLj55mQAfp5d2cT8Sh4ssroBoaeqiUUJvgqkGoSKFsx3UFtL/rw77h5hDb9YvhYbM1nh
FltVmd/MFaDx8/W0+21SRVbYv4rdzxpjBFPIiwBYTIjbUiCOmE2zSG4rrzF2HGRibs08GE/q
dcg8YLQyvgyEyU0QPoSUZiZbJPgWXbNyqRMP6vmk1kfDq3LZgDurZcOy3JiX7Y8vu1ds05MX
fjoY37SeCg7v37TgZB7XuzZkT5bnsVzYVhZQ5joGo7ZeQ/IcVoUQpzEDSVksPYHyWeQItV7W
qXAu6Q9qt7YgBe1OdgEkKZ6K0tJd5AyldywI7ZBCatqeVjmKDp27ZDbfdEf0oKIgnAcbYste
IPoTkdxSxloGtIjVXKeGvUg8J4aJBZqi64F8kruTbPFF6DWYcc9SU95VJFDxdYjjiJ4TlXie
eJkXXXsHh2M/MODZYiF46BFmKjlak4cR7oAi8kVm6GNRh8V1TvNZc50tEg2bqwh94qgfD2cT
fCMBOxFVcOIx4NKgfZskV/9GOLvSKmdqKMGq3bxt4+PNNn7AsVkFktF6GmLaBePXdKnvqMOa
ScmMd3TzCXTqVOdrf3eCpYxf3PNsZCYFI13dhfEeAOKNseU12mCiaJaQFgtqFsqQnF/3knnb
DlD8gpcbCYEeTSldQR5tGOW3BGLQTcKVCgnwN4JomnzQNr/pYRvc+1G2uMf8FiAtOh7Oh8fD
a94CrfpW/1IHXBCDK5SlDgu0GwmgpOdMBhtiTYKXeIzwxksiYrVzCTO/KGp3/0hGvcfXw+O/
qPOrjLL+eDo1/PuU4iPX5cBBnKTYqGhAdk9PmvpPLen6xae/a68UQZOF9LLfi0RIaY3W+I1e
FK5hpVgRPtBaqk56xMHCyJNUTVLY+dhd+/WrKp2Qu1Q2+6rZ0+zOauTiOyHjSMPs22GfsLEs
IVJhqF1Mjkkih2CpKCBivMyYT1jU5pj5bX96M8bvtauY6WBOeB4UL5PT206A2nf1+33CULOC
mV3NZti/HVBLa1GBnNxn5O5M/m13/UZ8ejsk7nKrmNGgu7yB5BmYhAB1Erl451AuJ5Mprgis
Ym5vcTeyEhNxn95nGUwikvF41p0P3E2Mbv3uJjMga3il2Zid3E5vu7NaCTaZTojlrcDI/uBK
J1rJ6WDYDVlPh5PBrdvd7Q3IIVC6TRk+ja0Z8KeE6OYgAe6+JBFWYz+fYLt4i/sMhVsNkkfj
Cfr5en75+fn+qHlXczUvMhP5c1BOzvrq5E3tPg3Ed9Q21XM21PbtgnI9bhOaLoXxwQ2e0CIp
sc1mN+MBuXXQOfA+3Dt3YlwxGQ36WeQLvCSu5JpsguMjDHQUgtCXgYxy34JX37HgIeN+SJnb
AGbp+JFHUCDDF8oJNYacB7BIIXTo8CzvlMY2Hw6I60eQJ/6YsJ9n1mZ80/YqrT8t/ahDuk04
ocYGsQSng+FwvMlkojagdA+SUTIZz/rdnWS1mY7xGU131Fg8hAHrzGHtT4d9upfFzgLI6Ilp
POYdNeXYgul9BqbNWhx3H88vj6f2ncxqwVTBrYqayiRogp8F8Nf2K5oiO/YzO8q403YAZDzq
/ck+n14O6phRBh74C4/xxXy75738c9wdf/eOh8/zy/u+NEOfH3dv+94/nz9/wjGl7XY+pxiy
+NLTalM1U5AVoUpzOrxqV+SP193vfPJqV4vxXW+pMGrJ6q+X+kHyY3qDy+NwnfwYjCtzcJgG
7XAdrrDbBVCJtW2hsIEDTB3OtmpAxOr8RRhvKyCltE1dgd2hQNY5pUzpJPuxfwR9GTzQsvoH
PBs1Dd91Ko9RllItg/uC1gMp2K0QT1iOtxRV4wGVxtWaGG+baer0H2ybefMwXTB8HGmxHjDE
qy93N7VnVM0uwiAWCT4EAeL4ajeLr+da7DmNpa4qfADy28Y7F45vCUIhq+XzGF86Qajyo69o
NGBLf8qaeZLwpdMv3sY0wSQABBz4iU8VstUX7phFrOAglWsRuKg9hPnOIFFHRNk4SoFXI9cH
MDJfzwnCVUhkC5d/WD8v0uEHYUVQQojOAPI49dWmK2L2oAu1mI1uuuRr13G8zk7ns4Xg+jKt
A7KdeyzBbHlAHDum69cHnjEWDeeykRwCwXS7J2u2z+7uGBB8xCAD9yH8cg+kEQtgv+yFHUMl
ciTztgG+T9EA0H8S7qVaDveycRg0KK3rmJgkwXO1B63o+ozcRI6Ww5G8SSNXR5BOb7lUdRY1
1VO0KELf1EceoeLVnYFSGcGkAFenagdMD2Tt43sXbjtfIcUK3+ZqYRgllGJCy904TaTRj5Kg
FFbJLErwnTogNiLw6UI8OHHY+QkPW1sthx3TozkEZi5BeKeXRw8NKpiqE17ocpF5Qkq1zWgG
mgJ5vv+pJ+qrZQhl4/La5iJFj4bwRCWsBYAwr0FIj55/nyAcbM/b/cap34Iw0hluuCNwdSdI
F8xeEHo0YBXGd+/wYAzbrQ7+U8CkHuimiSZL14QlmU8cGdRCT1obBM4aokDhb2IcQmgKS3hU
bBWh/hsIiwXYbi1WZ0wTKLWSwNXcndSTXC7DZIsn5lZ1P/44nh9v/qgCwA9Mda36U3li46nL
qURy8qYCZEF+x6u7g0qom1pVgCKQc8ORUX+/TgcaFyS5wY5WTc9S4Wg/I/wsBaWOVy3Fenmh
AyVtdHU4tdWTW9n5o76c4ZNKDYKrZwuInfSHN7gCsgbBz6JVyKi7LBqC6wSqkBmupSy/iG0m
sz5OG1Vg4tktoQMoEZvReHoNMukTWusSkoz5cDS9Xt4r9Rvx+aA/uNKSPLqtazir3XDAMzWE
q3yF0H/giqPdvZBaHw4IIoR6CbsbL16pfjSrU2WbO5vX3RlC8lwvR38w7W5ZBRkTCtMqZHy1
J06m42zOfOHh02IFeTu6NjgGo5vuIZbIZf9WsisdZTSVV74eIEOqDxSA8aw5SWlJ4k8GV77E
uh9Nr/TUOBrzK0MLekH3sDEXma1ucnj/xqP0WieZS/V/N1cGZhIQN2jld9wOb9pk1aCCSPbv
wH5GlMIG5e+qyfRnGA18ZqXzSsSeiyYGCEghkiC+RqcbWyQRRdiZUt5kIi4oULF9G4hFqLYO
QS0sdZ5MUa8VT/kI8a3/8ng8nA4/zz3398f++G3V+/W5P51REyfJSG4vd11E22zry/S9bnL4
PBKafiY8K8SUPiL0/bSyD60x9WphL9r92psQYQ0a4nj/djjvgfcO7XaOH0rgK2wrIeOPt9Mv
9JnIT4q6ROtAq+aazCdm1lbv+TPR8cl74XuPP798/NU7gYbsZ8k5XG4R2Nvr4ZdKTg6t3YN1
POyeHg9vmCzYRN/nx/3+pDbR+9794SjuMdjL3/4GS7//3L2qnJtZVz6OZ7JtoLCBAI//UQ/l
ZkorjscBinzYZM1jB6f3dDbAiELtnUMijr0gWieQ+PYcGEtJdvI14p8Q3/ceVQO29a0s9jPg
RgK1dxD/6FfKBB6Q5Fv0zT9ofKU6g3jEiXPut7tq5G5rge9LcBG0FABYZhb3syXcM6hDzYBE
gflEwTlu4zoqgIBFjfA3U/+eNK8GWLRh2WAa+GAXQtB2V1FQMhLls0hH1sh8259Q3spaa0fe
ORFBMmLWXgLY+9Px8PJUrWC1K4tDgvDJZqjLcvUI466BQucRvHPQeRbXvmjigIxQ2mtqU1RA
sW2JkLh994SPmajNIQaj6WtVAp+NHGTV41aekG2ABLGdbGLBM+61RYnDU4gWWvNZ3MhhRjAe
KtkoQ/nUVWa+VURVqIwzAeHQEyq/O1q0oUWLOfg+4DJLdrwuEF7Ho/NB68nLx6GVCItkPWBv
kWaiwWYhqgqCHUwGchFULIJ9MOKWao5tyiv9CugCgG1boM6w8yQIpZhXblrsZoIwCSbGYC1k
hRGgFXOfhhK7dGGpDOcJdIiKI4ROM0mX3MElhKj1nGO9ITaDc/f43LhFTFrRL41YE8B+B+pu
GDOtISOScKZmrUax7kJPEIqrB/UEUeDUnmOFtcPk+5zJ74FsFOEyAerYtUSuK/Us2W1lq2Oa
xei0/3w66EitrS++EOhWE5Z1w2+dBnfx0msk6vidfhgI1SGr/UQLuSs8O3awLrh04qD61kIx
dNEINuMxlBLzhxqCmssYBoYhParlGcYsWDj0sGd2h2xOy9xOESiSyVmoozQWLep4isfMp2ho
71OWuFS/6phHgZhoQ45Lv+PrI1p2H2xGndIJ1cRx/srLZGJSwEYAIilvmyG2jTgMyvRLNwWj
OsJ4dpusqNKlVNEK89Z6ByyEptS136tB4/ewRheiU2A1wcc7iIk4ZLBoNyL8lrURyiyojzb1
E1NHL7R7TwSW+xX/SajE5k9VjvqHAKtGI+52HNU4D0xKR8ggHQeK6uaCnB1sRo9hqtm8arN4
SREl88cfL6fDdDqefetXVOIAUK9x9Nw3GuI6uhro9ksgwiyzBpqO8R11A4TvzxugL73uCwWf
EmauDRCuxGqAvlLwCeHrXgcR46IO+koVTHAVYQM0uw6aDb+Q0+wrDTwjlMd10OgLZZoS/rsA
Ulsb6PsZrkWtZdMffKXYCkV3ApZwQbgfVspCP18g6JopEHT3KRDX64TuOAWCbusCQQ+tAkE3
YFkf1z+GcBaoQejPWYZimhH8vIWYCCXtgbU9h9WXYK4oENyBiN5XIOqEncaE/qgAxSGT4trL
trHwKL/6ArRgpOt9CYkdwtSjQAgOrv6Et22BCVKBnyxq1Xfto2QaLwURqhMwqZzXRnHudfv4
eXw5/8Y06EuHYq3PNQGZ7TuJVpDJWHDKB9FgO4Xogqx9410W206gdnRwCOVhtNWxzjhrHDVa
MPx1EK+eawyEUibDqRXxsS/fyZDo2aU+5I/ygt1EtyrUSPz4++N86D1CFL7Dsfe8f/2ohoIz
YPU9CxZV2PhqyYN2usNsNLENtbwlF5Fb5epqStoPQehPNLENjasaiUsaCix3U62ikyVZRhHy
+RDOe1Bt+uIdRJSKXEwwuOdSh9uYYVwuNWx/7VrM07HSQBe7mmFmiwT4KrSFQoLkspj3B9OG
eUMdATHiWuWCxHbNwZnkPnVSB3mR/oNGkstrPZWuE3DkSdS4gn2en/fv55dHHY3JeX+EgQD+
JP97OT/32Ol0eHzRInt33lVnnKI4nCADy6ulW8xdpv4Z3EShtyUtKMqBsxBw//0VDH7+qoIG
YyKwVt7sYZwmkxG+SapimtEbmqDEuRcYVVHZm12mTuurYh6y9A3f2+Gpao5TVJaFtSonLPAL
scQ3A6UYm87Lwlm1wEYm1Ytxg/ZcHM4x87VcGME3tLPcEHGQitnF2a5j4vahaFMwupNp+47J
3Z2ey/psfT1OLVfMpD7DKnyjvqGrKKtGpjmb/6/96dxu0pgPB1iNaEFnw8Vc9m9sKiRzPvpc
RmwyivZAxl2jk9uj9mRqj9tpQvVkx4O/yOfEvn1l5AKCOJdeEFcGrUIMUWrFYiy6rN8quEpU
2WLJ4/4A+RQlIPjJc7nfLYZ4pVZIaFDyiXoR92edrb+OVOFanYy/fDzXnEPKCQ9bsVRqRlh4
F4ggtUTH/MBiProo9cr9CjDNqo0JJShUTUinZ0A2jfqBlAiI8V0835aN0dRJK9VGa2Su/3bO
RC57YPgJoWhf5iWMMO9pLHrdywZKhVtK40gdsLDe6RPs+MUWoKNy5TpEGy5Pv9R77rv19nHc
n07Gj6xZvXOPSWz34j3gR8JcPCUMsMqnO79Oid3OqfkhkW2Hr3j3/nR46wWfb//sj8YmpvCO
aw8IiPkWxSj/U/HtsbUorIoQCbGoGBnu81GBtPK8E+CF5oC9Q7QlNreZOpy08iaBSb7J/xI4
JmyYmjg49HQB3XV7Mtsfz2DTozafJ83oCeHSdzr0zePz/hH4OAuDG8R3Mc/eEhJif8dVQsLC
okPNxAFXh9Q5hFrN700RiOcEhBTIOlMpqrro0lqEQ8hcEzC78q1cbZdVgxE1wQmjXXiuc63n
mZBphlEK6m1EowxD4Cr05s3TQB3gCe5Y2ynyqJFQ41BDWLxmEr+lMQiL0KEoKaEHVhJScIt8
hicsbG/FCQtTTXrUXTEPwFQlgmJiq6Zeprvi7Q8wB8Lxt046qSYoNH3zkAcCqf3ONtNJK02b
4kRtrGCTUSuRxT6WJt3Ut1oCIG9t52vxuxrrkkkl6ujybdnioRoapCKwlGCASryHarjYimDz
QOBDIr1SE+Bgo3msmklgz5HVQtpDei1ibaAW4SzRNq3gmriQbkMGApWFVlZVmr/07NF2rQCa
QwyZqMr3tvCMdqzyBfcV9UDg1W1+iomFyVDtsKtNzb0HoNKsjdQwtgltqG0TvMLxvWaCQxo1
AfuvsFK2RA3fxtQGSsVggQ4fPUMv98f3/WvveVebtz+OL+/nf7UR/tPb/vQLU2xGKmO51NxD
2GyV+3Z74UIHgi1VV7ck4j4VjvwxKu0PVI+Bu45WDqNLGXS42LwgttOwQy43Qy+v+2/nl7d8
eTrpz3o06UfsywyrkJpRMIdXJ9DaJj+F/a7rVG/H57HaJmdrFgc/+jeDUb0RoowlPoSfpOwj
ma0zZgS9XxoAuTJkYIUenocpN64GdoD5IylL3HgmcThYOIHNh88azmHFNzQg+juzMPC27ex0
kI1s7bAlXHnD+EIy1O62YBwQV2IWVBJLFbGp8R83//UxVE68W5luoARgFaNj0Rj77/3bQe1C
7P0/n79+mW5+6cbQx5yNBNdowhDXZAlAPTGgGJ1NFIokDCjzcZNNaN05nNCq5I3hMVxxlIsl
2NmmMDY6UCucrA9Exq5Yh9tsN50rFm6DHa8Yr1zPnEuWsKBChFCXKhkPVzmbad1KIS+9C7bF
LSUMtEzPOzz++/lhxqe7e//VsM2eSzCQSCOVk1RViAb+NqLMTQMIAZosq/3C9KZSpGeuMJU/
+oOb+oyillvmV4ARw8OQkdhsxbxU9dhLtut7lIuo0n3gMTW8QtyAsSYvs68Ji8+pvDVRw93u
sAvRclgiqXi88Ljpb05gm8mjo89BCZaOEzUGgDkJgPa0HIC9P08fL++aku7/em+f5/1/e/U/
+/Pj33///Vd7Kob9QCqdDeGNnfcsxDejAbmeiVnF1RBUn9EBy01FzbEsX1rxbLVRquqrMo0d
mp1wvTZlQ9fpCwpmXDUFqbUAtBCqbcz2uKOgSzPdUBeDBqT+VScxK6yexRBJsw4EUcx8uhTX
EEnXNKmNY4VDBKrPef9iVQkQSrO+HhrdAU/x+V4JYFGa040BiKstpkEwy5FS5z7pGHrmC9S0
YNbKuLVKNpDGulmtU+BNQtxz51WWOXGsQ/DdmSUbBZvJsBsD+2PWwa8apwEMeV1JMBqaHluQ
rjuBmrwJejMNIaVgh5gTY6tx0dEYFuhuafn/93VFOwyCMPDbUGQaRZcqiW/+/1+svWbRjZZH
bWOknHBAe0pRAfGgebXdGBbcCb79S/HbXymaNA5nLNkeQrTNysv19NwGOfxmdjycIgY4gP06
ynhi1yVB086gcfTQ4FGKUwQC6xmInPo/2CXbPC2bfTIFD5IdMPxzoBFPb5MM1inax9YKwNlR
XEfbZB/MTXXQAL3t6KaJp0SO3tUNaz/mQPbMg2ekibKr2Kt4QE5440Wr5c0/npCV4WabKJjy
1uhJpn19YECZHmx0EQ9au14xHEFWuFSqcombUoT8XgY3UQXrc5GXvyei+uqhyP2rOgZjlQZw
30XiMnM2883gNkebeZduN0WVdHBiRpuW8NofVZwfg71eTgC6AAA=

--cNdxnHkX5QqsyA0e--
