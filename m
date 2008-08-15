Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7F1ddta016235
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 21:39:39 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7F1ddfd001117
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 01:39:39 GMT
Received: by py-out-1112.google.com with SMTP id a78so1095749pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 18:39:38 -0700 (PDT)
Message-ID: <48A4DE2A.3090002@gmail.com>
Date: Thu, 14 Aug 2008 21:38:50 -0400
From: Ivan Gyurdiev <ivg231@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com>
In-Reply-To: <48A48B8C.3070908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Patch speeds up semanage command from 17-20 seconds to 3-4 seconds.
>   
Hi Dan!
Some suggestions below,  if I can still remember correctly how this was
supposed to work:

One issue with the patch is that it makes an already large and hard to
maintain function even larger - it would be better to split it up and
make it modular instead.  Likely "merge_components" and
"commit_components" should be changed to pass the components to merge or
commit as arguments - so you can operate on file and policydb components
separately.

The "attach" calls shouldn't really be needed, since you're not
re-writing the policydb, or changing ports/bools/etc. It would be better
to change the rest of the code, so that the attach calls become
unnecessary in this code path.

On the other hand the code that parses out seusers/fcontexts/users_extra
info from the module package may be necessary, so that your local
seusers/fcontexts/users_extra changes are properly merged with the
shipped policy files - these are the "write_file" sections above.

- Ivan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
