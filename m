Message-ID: <45B79D42.9030103@redhat.com>
Date: Wed, 24 Jan 2007 12:54:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libselinux python binding segfault patch
References: <45B7968E.8040106@redhat.com> <1169659880.15390.121.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169659880.15390.121.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-01-24 at 12:25 -0500, Daniel J Walsh wrote:
>   
>> This patch fixes a segfault in the python binding when getfilecon is 
>> called with a non existant file.
>>     
>
> Is the bug actually in the python binding or just in the callers?  The
> actual bug report on fedora-selinux-list was for chcat, and chcat wasn't
> checking the return code from selinux.getfilecon and just dereferencing
> the string.
>
>   
It is in the binding.  Basically we we not setting the security context 
to NULL before calling setfilecon, and then checking if it was null, to 
figure out success.  The real change is in selinuxswig.i

#python
 >import selinux
 >selinux.getfilecon("/notafile")
Segmentation Fault

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
