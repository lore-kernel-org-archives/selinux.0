Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2N3Vxaa020491
	for <selinux@tycho.nsa.gov>; Mon, 22 Mar 2010 23:31:59 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2N3VYYW003683
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2010 03:31:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dominick Grift <domg472@gmail.com>
Subject: Re: squid and apache
Date: Tue, 23 Mar 2010 14:31:38 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <201003031007.35281.russell@coker.com.au> <4B8E3807.3060809@gmail.com>
In-Reply-To: <4B8E3807.3060809@gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eYDqLYnbbZoLLKe"
Message-Id: <201003231431.42221.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_eYDqLYnbbZoLLKe
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 3 Mar 2010, Dominick Grift <domg472@gmail.com> wrote:
> On 03/03/2010 12:07 AM, Russell Coker wrote:
> <snip>
>
> > How should we solve this?
>
> I Wrote a blog with my view on this issue here:
>
> http://selinux-mac.blogspot.com/2010/02/about-apachecontenttemplate.html
>
> I am also interested in other views on this.

I've attached the patch I'm using for Debian/Squeeze.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--Boundary-00=_eYDqLYnbbZoLLKe
Content-Type: application/x-gzip;
  name="diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="diff.gz"

H4sICPw1qEsCA2RpZmYArVhbb+I4FH4mv8IaVmqrBEjCtbS7qtSVVvs8o9nHjElMsZrb2g4M8+v3
2I5pCBDqdnlo5PhcnO87Nzeh6zUasAqNRFaOGFmXRUrj/ah+jLIiqVLCR7gs4c+OCyz4UBB0Zd8Z
DAaWJnuh798PgmAQLJAfLv3JcrwY+uaH3CDwfcd1XXTdTuAP/PEgHKNgvBzPlhP/xM7TEwI/3gyW
C2+Onp4cJPYlQbWZaItZlNJVJB4ctKbgJZLbtyfbdw5yXFzieEMiHjNaioj8JHGUFBmmuZEHqVom
LnJBchEJkpUpFqQh4aD+O39O8k7SOGFbGiuIpPchXaPrIu+h7lSrhfo0WI7v38XedVNA4Pg8gYEX
hHLthQtFYb/fexzxKssw2/8hl+hxVGKGM7lw3APoPy4yduP9cNyeCoWNEGUS/RYcSYkH1EdxxUWR
0V94lZIHx725c1zHfTd5rjzW4ZCw6j0zAqdCGHEiULFGCWF0SxIVkRytC1ZHjxLekRWqo2iobY2a
xtCj+mCU44z8/qUECunPL9rNsdNvG0hitY1EgVYEVRxcSmfKPc1fdEZIQ3yoDbQ8GWzdPmRPG9t2
pEtkUe+F5BEj/1aUgSSse1gIRleVqPGutR7ObGkCNBn8rMARUXB2JdTgUnhGsNIyZp0WLzLT3V4n
82ANqEa9PsJpWuzQjlHJWgzByyWGZbWC0FblAgmGc74mTImbENeVZKhidzyDsuNOQ+9eRW6PFaDF
9xzgiljNfPsc8gjK4LcN5ZodeB54k8eshAxKVKOkHTqDrs/yLoF3GujgOYM3MlgSCJwc/K72SEAg
xYAIfKyU+J9cyfdtftv2OmiPC0biDPY2JE0jiCi21xX8BFPJqM79WkxidirmXTiDLNwfLcdn2uip
yEfK8UkT/Hg5Pu2nk4v9dK4b6tx01LpxZmUTU5N78FborifLXlWqONIJgDQfKqjrN89//W2Cuqvf
gnRHr9W7TjNE1TEe6nFgpueBeXMgOIiteXMYUOvGV9UCV8YBSFXWcb56u1rhWG5yKCIyyWoXcrcZ
tXINdvX7TZEdDDblDz7uPhKlcVXy5EqYGhnLODVqeurzFwN/hnx/OZ1Dvz+KLv96oDZstSY/Pzgf
qf5EUQ0PTTWUdG0lil8o+pPEKXQ2QYEDOTh0j3hvikBKUUotnEb6uKrHXRz9jjTt+Ym3vJMbvW/F
i1b5PCcHO63KEc4u8KFTz58d+Hj+/vUfmHS0h6skgD9L8LWGPegvVHSCrvetQNcqNejzQTBBYbgM
oczO7UA/2GmB7odnQZ95E+TOvGkNuFXQg6uOOqZ2rZHNqpzmndgaCSt0jdKZoLbEt2GpVWaC+wv3
E11mAlNmTMlOADFcJVTIIh1VeQkDt67X64TfKj9HJf5NnhPM4k2j5ieUNTW6SFNSlmlidOzphLtF
WiXdQ86bjBWlb2qfJ/XIVrt7nKc1nCta5cNUK7Cyo6+v2L59GE1LXhpq9tRwuH91t3UjYUWLUfo8
KQ1LR5RMl5MLmTadq0ybmtlNXQByIhMmT+AqsI3ghhIBmK9E8FtlX+XLzZWcUZKW3Bgde2J247iT
Fr1vRYpWOdNcFnaUHOy0ciRcXGguM9lc5h9pLuAq2uKUJlgUXeNyW87iH2j/AU4Tkej2FAAA

--Boundary-00=_eYDqLYnbbZoLLKe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
