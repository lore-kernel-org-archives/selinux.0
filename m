Message-ID: <43F77E2B.3050108@cornell.edu>
Date: Sat, 18 Feb 2006 15:06:03 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Joshua Brindle <method@gentoo.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net>	 <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org>	 <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>	 <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>	 <43F5EE32.5080101@cornell.edu>  <43F64063.4040601@cornell.edu> <1140288277.18548.28.camel@gorn.pebenito.net>
In-Reply-To: <1140288277.18548.28.camel@gorn.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> gorn selinux-usr # semanage login -a -s staff_u pebenito
> libsemanage.validate_handler: MLS is disabled, MLS range s0 Unix user pebenito ignored
>   
Ok.. message is missing a few words...

> gorn selinux-usr # semanage login -l
>
> Login Name                SELinux User              MLS/MCS Range
>
> __default__               user_u                    None
> pebenito                  staff_u                   s0
> root                      root                      None
>
>   
Right, this is s0 being hardcoded in the semanage tool, so the bug needs 
to be fixed there.
What I don't like about this is that libsemanage skips the MLS check 
now, but still proceeds to write any MLS range found to disk. It should 
invalidate an MLS range if it sees one. Will submit another patch on top 
of the previous one...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
