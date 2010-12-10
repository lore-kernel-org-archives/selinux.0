Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBACTpmc010128
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 07:29:52 -0500
Received: from out3.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBACTquK021030
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 12:29:52 GMT
Message-Id: <1291984191.3883.1409660307@webmail.messagingengine.com>
From: "Roberto Sassu" <roberto.sassu@polito.it>
To: "Dominick Grift" <domg472@gmail.com>
Cc: selinux@lists.fedoraproject.org, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4D00B88A.9050704@gmail.com>
References: <201012091148.18323.roberto.sassu@polito.it><4D00B88A.9050704@gmail.com>
Subject: Re: selinux policy for encrypted files
Date: Fri, 10 Dec 2010 13:29:51 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 09 Dec 2010 12:07 +0100, "Dominick Grift" <domg472@gmail.com>
wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/09/2010 11:48 AM, Roberto Sassu wrote:
> > Hi all
> > 
> > i want to write a policy for encrypted files.
> > In order to do this i created some new types which have the
> > name of the correspondent type used for non encrypted files,
> > with the prefix 'encrypted_'.
> > Then i need to define the policy for applications that need to
> > use these new types which is very similar to this defined
> > for original types, except that i want to take rules only
> > for the 'dir' and 'file' class.
> 
> And what are you trying to achieve with that with regard to security?
> 

I think making a distinction between inodes that contain plaintext
data and those that contain encrypted content should improve how
security decisions must be taken for the latter type.
For instance, assigning to an encrypted file the label 'encrypted_etc_t'
allows to significantly reduce the number of domains that can access
it while keeping the same meaning of the 'etc_t' label.


> > What this the best way to define the policy? Do i have
> > to duplicate all required interfaces/templates or can i reuse
> > the existent code, for instance by adding a new parameter?
> > 
> > I will show an example of what i'm trying to define.
> > 
> > New type: encrypted_etc_t;
> > 
> > Example interface:
> > 
> > interface(`files_list_etc',`
> > 	gen_require(`
> > 		type etc_t;
> > 	')
> > 
> > 	allow $1 etc_t:dir list_dir_perms;
> > ')
> > 
> > 
> > Added interface:
> > 
> > interface(`files_list_encrypted_etc',`
> > 	gen_require(`
> > 		type encrypted_etc_t;
> > 	')
> > 
> > 	allow $1 encrypted_etc_t:dir list_dir_perms;
> > ')
> 
> The above examples are exactly the same. In that case you would not even
> need to create anything new. Also why would you want to create this
> whole stuff new just to be able to exclude classes other then dir and
> file? How is that beneficial for the security point of view to you?
> 

Ok, i choose this approach in order to minimize the effort required
to write a policy for newly introduced labels. Using different
interfaces allows to add an extra call only in desired application
policies. Further, i defined new rules only related to the file and
dir classes because, in the former case, i don't want to assign an
encrypted label to files which are symlinks pointing to unencrypted
inodes and in the latter case, because i need different directory
labels in order to configure type transitions correctly.


> Comments i made above asside: it does not make to many difference
> (afaict) whether you extend existing interfaces or create new ones. if
> it works, it works.
> 
> > --
> > selinux mailing list
> > selinux@lists.fedoraproject.org
> > https://admin.fedoraproject.org/mailman/listinfo/selinux
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.16 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAk0AuIoACgkQMlxVo39jgT82owCePwRysaVkriSvqGQmqr88wDLU
> 9KoAnj/H5TJKZD0+78M6hok+30x7eCfv
> =BLwh
> -----END PGP SIGNATURE-----
> --
> selinux mailing list
> selinux@lists.fedoraproject.org
> https://admin.fedoraproject.org/mailman/listinfo/selinux
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
