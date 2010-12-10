Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBACa2ka010759
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 07:36:02 -0500
Received: from mail-ey0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBACa1uK023251
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 12:36:02 GMT
Received: by eyd9 with SMTP id 9so3081834eyd.36
        for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 04:36:01 -0800 (PST)
Message-ID: <4D021EAC.3080804@gmail.com>
Date: Fri, 10 Dec 2010 13:35:56 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: selinux@lists.fedoraproject.org, selinux@tycho.nsa.gov
Subject: Re: selinux policy for encrypted files
References: <201012091148.18323.roberto.sassu@polito.it><4D00B88A.9050704@gmail.com> <1291984191.3883.1409660307@webmail.messagingengine.com>
In-Reply-To: <1291984191.3883.1409660307@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/10/2010 01:29 PM, Roberto Sassu wrote:
> On Thu, 09 Dec 2010 12:07 +0100, "Dominick Grift" <domg472@gmail.com>
> wrote:
> On 12/09/2010 11:48 AM, Roberto Sassu wrote:
>>>> Hi all
>>>>
>>>> i want to write a policy for encrypted files.
>>>> In order to do this i created some new types which have the
>>>> name of the correspondent type used for non encrypted files,
>>>> with the prefix 'encrypted_'.
>>>> Then i need to define the policy for applications that need to
>>>> use these new types which is very similar to this defined
>>>> for original types, except that i want to take rules only
>>>> for the 'dir' and 'file' class.
> 
> And what are you trying to achieve with that with regard to security?
> 
> 
>> I think making a distinction between inodes that contain plaintext
>> data and those that contain encrypted content should improve how
>> security decisions must be taken for the latter type.
>> For instance, assigning to an encrypted file the label 'encrypted_etc_t'
>> allows to significantly reduce the number of domains that can access
>> it while keeping the same meaning of the 'etc_t' label.
> 

If some domains interact with encrypted_etc_t but not etc_t and vice
versa, then, in my view, it is best to manage access to encrypted_etc_t
in a separate interface.

Because else you get into issues where for example a domain that calls
"files_read_etc_files()" can also interact with encrypted_etc_t, whilst
that may not be required/desired.

>>>> What this the best way to define the policy? Do i have
>>>> to duplicate all required interfaces/templates or can i reuse
>>>> the existent code, for instance by adding a new parameter?
>>>>
>>>> I will show an example of what i'm trying to define.
>>>>
>>>> New type: encrypted_etc_t;
>>>>
>>>> Example interface:
>>>>
>>>> interface(`files_list_etc',`
>>>> 	gen_require(`
>>>> 		type etc_t;
>>>> 	')
>>>>
>>>> 	allow $1 etc_t:dir list_dir_perms;
>>>> ')
>>>>
>>>>
>>>> Added interface:
>>>>
>>>> interface(`files_list_encrypted_etc',`
>>>> 	gen_require(`
>>>> 		type encrypted_etc_t;
>>>> 	')
>>>>
>>>> 	allow $1 encrypted_etc_t:dir list_dir_perms;
>>>> ')
> 
> The above examples are exactly the same. In that case you would not even
> need to create anything new. Also why would you want to create this
> whole stuff new just to be able to exclude classes other then dir and
> file? How is that beneficial for the security point of view to you?
> 
> 
>> Ok, i choose this approach in order to minimize the effort required
>> to write a policy for newly introduced labels. Using different
>> interfaces allows to add an extra call only in desired application
>> policies. Further, i defined new rules only related to the file and
>> dir classes because, in the former case, i don't want to assign an
>> encrypted label to files which are symlinks pointing to unencrypted
>> inodes and in the latter case, because i need different directory
>> labels in order to configure type transitions correctly.
> 
> 
> Comments i made above asside: it does not make to many difference
> (afaict) whether you extend existing interfaces or create new ones. if
> it works, it works.
> 
>>>> --
>>>> selinux mailing list
>>>> selinux@lists.fedoraproject.org
>>>> https://admin.fedoraproject.org/mailman/listinfo/selinux
> 
- --
selinux mailing list
selinux@lists.fedoraproject.org
https://admin.fedoraproject.org/mailman/listinfo/selinux
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0CHqsACgkQMlxVo39jgT+z0gCfYdmfbi8xSmHqjEWVp/draMnI
o4YAn0fyNGx3OkFUL6uaIQi8I4FGTm0T
=pHYb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
