Date: Thu, 3 Dec 2015 18:20:51 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Miroslav Grepl <mgrepl@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151203172051.GB29999@x250>
References: <20151202101801.GA1028@x250> <565F366E.3030403@tycho.nsa.gov>
 <20151202194715.GC1028@x250> <565F6167.5090507@tycho.nsa.gov>
 <56606797.1070609@redhat.com> <20151203163049.GA29999@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20151203163049.GA29999@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Dec 03, 2015 at 05:30:49PM +0100, Dominick Grift wrote:
> On Thu, Dec 03, 2015 at 05:02:31PM +0100, Miroslav Grepl wrote:
> 

> no boundaries because there is no least privilege. E.g. most is just
> allowed to run in the user domain. It just not unconfined (but it kind
> of might as well be)
> 

Fedoras' confined domain are only there to protect the system from the
user, and the user from the system. It does not provide integrity in the
desktop, in the sense that applications are confined to any significant
extend.

if all applications run the in same user domain then, yes there will not
be any widely requirement for systemd --session access control becuase
theres nothing to control is everything runs in the same domain

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWYHnvAAoJENAR6kfG5xmcDscMAJA3evR/KWoVwaD2eZKFV2Mt
gNw31zE0Hdl6terZyyWqJmDMDH8Lyrzj2SbgTK+h4kXpu5lmxSLgU56KwIB024AE
28ObjOjnQNe/TdCifAG5vvSf4NRW4MnTO0zed9oGIHcQdjbWouWfODZP8aAgxc00
3MAH7Z9/sES3XjcIsBm+q4BI0TYi2mDCiM0HQskJMY7r71ldn5myUZOawme2rMPo
RquoMRwnPTa5iTzsjoK8ssISxwDJeX7WIMfQHz+oORi5Y0PLXrZE3I56Sr1b2JUm
Rj95mxvHpQM8WcSUSveOjVd29iNyAYD9EhAlVBrxrvMVNz/LHpgUyY+p3jm3FV+B
QFKtY42jqxTEwjuzoA3ZO3jJz6sZqrFMqYnKR7M04p7t1vFWu+uMWHL39yVc6mYp
mOMDH1vd/vif3omIpE6Ii6Fq5aGnXxWLtHi6GIldBh0a9FKVruGQC3Q/YMhXZQm2
gkJEeyAGQNv7j1V4yRs/w8laRwSTQE62MGvWKFvaGQ==
=Ixgi
-----END PGP SIGNATURE-----
