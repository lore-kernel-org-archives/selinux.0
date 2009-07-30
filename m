Message-ID: <4A71D8CE.1010700@redhat.com>
Date: Thu, 30 Jul 2009 13:30:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Cliffe <cliffe@ii.net>, selinux@tycho.nsa.gov, slide@tresys.com
Subject: Re: Help with SELinux policy for Usability Study
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>	 <4A711890.2030101@ii.net>	 <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil>	 <4A71AD1A.5030406@ii.net> <1248965089.11627.137.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1248965089.11627.137.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/30/2009 10:44 AM, Stephen Smalley wrote:
> On Thu, 2009-07-30 at 22:24 +0800, Cliffe wrote:
>> It adds the permissive line to both (I am not sure why kwrite seemed
>> to be in enforcing mode). But the gui does not make this clear. I have
>> mentioned this to the fedora-selinux mailing list.
> 
> Perhaps kwrite isn't actually running in kwrite_t at all.  Note that kde
> has historically had a problem with launching all applications via a
> single kde-init program, thereby preventing automatic domain transitions
> on the specific application from working.  Not sure if that has been
> fixed.  I don't use KDE.
> 
>> None there. It turns out they were in /var/log/messages
>>
>> so 
>> grep kwrite /var/log/audit/audit.log | audit2allow >> kwrite.te
>> did the trick. It is strange that some AVCs go to /var/log/messages
>> while others goto 
>> /var/log/audit/audit.log
> 
> That seems like a bug to me in dbus.
> 
> Again, I'd suggest that you also include SLIDE in your study - it will
> add a further data point and is a more flexible solution, even if it may
> be slightly harder to get started.
> 

BTW, if you use the sepolgen command line that is in F11 and Rawhide, it has new features to examine the executable and rpm information to generate more data automatigically.  It is using the same framework that polgengui is using. 

You can execute

sepolgen /usr/sbin/myapp

And it will generate the myapp,te, if, fc, sh file automatically, No gui to walk though.

For example it will look for paths in the rpm that match /var/run/myapp, /var/lib/myapp ... and create proper types.
It also runs nm -D /usr/sbin/myapp looking for function calls that it knows require certain interfaces,  If it find syslog it will add the 

logging_send_syslog_msg(myapp_t) 

call.

I have not merged this stuff back into the GUI yet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
