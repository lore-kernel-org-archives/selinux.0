Message-ID: <4E3C0202.1050506@redhat.com>
Date: Fri, 05 Aug 2011 10:45:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
References: <4E39B5E6.8000100@redhat.com>  <1312469767.20973.53.camel@moss-pluto>  <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>  <CACLa4puk2gO=aV=oNj-Kmj=eSmYmquX0skKoCxso6o9tWcf_Ng@mail.gmail.com>  <1312486409.20973.66.camel@moss-pluto> <4E3B007B.1020502@redhat.com>  <4E3B085D.1050400@redhat.com> <4E3B09CA.30604@redhat.com>  <4E3B0AB1.2050707@redhat.com>  <4E3B1416.5020504@redhat.com> <1312553911.19283.56.camel@moss-pluto>
In-Reply-To: <1312553911.19283.56.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/05/2011 10:18 AM, Stephen Smalley wrote:
> On Thu, 2011-08-04 at 17:50 -0400, Daniel J Walsh wrote:
>> On 08/04/2011 05:10 PM, Eric Paris wrote:
>>> On 08/04/2011 05:06 PM, Daniel J Walsh wrote:
>>>> On 08/04/2011 05:00 PM, Eric Paris wrote:
>>> 
>>>>> I also question the use of /sys/fs/selinux/ but I'm not sure
>>>>> we have a good way to find that in a script.....  Do we have
>>>>> one?
>>>>> 
>>>> 
>>>> grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }'
>>> 
>>> $ grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }'
>>> /selinux /chroot/selinux
>>> 
>>> -- This message was distributed to subscribers of the selinux
>>> mailing list. If you no longer wish to subscribe, send mail to 
>>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
>>> without quotes as the message.
>>> 
>>> 
>> 
>> Second attempt.
> 
> Technically I think we wanted to encapsulate all references to
> selinuxfs by using libselinux, whether via direct bindings (as from
> python) or by adding utils to libselinux (for shell scripts).  For
> example: $ gcc -lselinux -o getinitialcontext getinitialcontext.c $
> ./getinitialcontext unlabeled system_u:object_r:unlabeled_t:s0
> 
If we are going to add any more commands to libselinux I would prefer
them to be prefixed with selinux or at lease se.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk48AgIACgkQrlYvE4MpobOaHgCeKeAXbKuKtI/0nSfZ0CWBgqcC
ogsAoNbjsH0obxI3HVx44LrAQxNlUc67
=aG/T
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
