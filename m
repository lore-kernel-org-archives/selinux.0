Message-ID: <50EDE191.1030909@redhat.com>
Date: Wed, 09 Jan 2013 16:30:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ondrej Oprala <ooprala@redhat.com>
CC: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: setfscreatecon optimizations
References: <50EC1D32.3090607@redhat.com> <50EC31AE.5040807@tycho.nsa.gov> <50ED5C8E.4040202@redhat.com> <CACLa4pvjb4Y_AMcuTv_6Aoa=2QUhsWiZT6iknOHG3B6EQe2yTw@mail.gmail.com> <CACLa4pur4DFPnuj-v10DPuBQ4hDqnV0gb02zR0-+ORwiT67CFQ@mail.gmail.com> <50EDD041.70505@redhat.com>
In-Reply-To: <50EDD041.70505@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/09/2013 03:17 PM, Ondrej Oprala wrote:
> Fantastic :) thank you very much.
> 
> On 01/09/2013 03:51 PM, Eric Paris wrote:
>> Something like the attached?
>> 
>> On Wed, Jan 9, 2013 at 9:30 AM, Eric Paris <eparis@parisplace.org>
>> wrote:
>>> On Wed, Jan 9, 2013 at 7:03 AM, Ondrej Oprala <ooprala@redhat.com>
>>> wrote:
>>>> Thank you for the pointers, it helped me out a lot. I tested the
>>>> patched libselinux with $cp -a dir1 dir2 and got an approx. 20% save
>>>> in instruction count. The patch is attached. Thanks,
>>> Thanks!  I'm working on it right now.  You did the: 
>>> __selinux_once(once, init_procattr); init_thread_destructor(); Before
>>> variable declaration and you do not handle context==NULL, which is how
>>> you clear the value.  I'll fix both of those up and apply to the devel
>>> tree.  Thanks so much!
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
rpm -q libselinux
libselinux-2.1.12-12.fc19.x86_64

Has the optimized code for anyone brave enough to play with rawhide.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDt4ZEACgkQrlYvE4MpobPr1ACbBlS2t4VWOHIyn31RDx2YeRG+
NLkAn0tdu6VDDrfrnh4sXi+CttD9e4+d
=znNd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
