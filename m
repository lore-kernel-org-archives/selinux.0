Message-ID: <426654FE.9040206@hp.com>
Date: Wed, 20 Apr 2005 09:11:26 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: selinux-policy-mls is now available for your testing pleasure.
References: <Xine.LNX.4.44.0504191827130.17819-100000@thoron.boston.redhat.com> <1113998845.1028.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1113998845.1028.37.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-04-19 at 18:29 -0400, James Morris wrote:
> 
>>>12 Rebooted normally, i.e. 'rhgb quiet 5', and X failed to start
>>
>>Haven't tried X yet, not sure it's supposed to work.
> 
> Works for me.  Of course, you do need to have the allow_execmem=1
> boolean enabled for X to run, but that is independent of
> MLS.  /usr/sbin/setsebool -P allow_execmem=1.  Did the RPM include a
> booleans file?
> 

Yes it did, however, the allow_execmem entry was missing.  I added it 
via setsebool and verified that it was in the booleans.local file and 
rebooted to see gdm startup this time but I could not login - according 
to the xsession-errors file Xlib failed to connect to the display, which 
was running on ":0.0".

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
