Message-ID: <4B7EB1B4.3020207@gmail.com>
Date: Fri, 19 Feb 2010 07:43:48 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C47DB.40602@gmail.com>	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DB3B4.2070409@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780AEE@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DCA8D.8010708@gmail.com> <1266590132.32011.21.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266590132.32011.21.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/19/2010 06:35 AM, Stephen Smalley wrote:
> On Thu, 2010-02-18 at 15:17 -0800, Justin P. mattock wrote:
>> then after being able to build and install the policy  then I focused in
>> on the booleans, I set(although am not sure if they fixed the errors
>> with avahi)where these:
>>
>> allow_polyinstantiation=on
>> init_upstart=on(although I think they use sysvinit(notsure))
>
> I was suggesting trying to set the init_upstart boolean because it
> disables the transition from init_t to sysadm_t on executing a shell and
> it appeared that for some reason that was causing system services to be
> left in sysadm_t.
>
> Question:  Are your boolean settings persisting across reboot?
>

yep.. i.g. vim policy/booleans.conf(make chnges), then make policy
with the binary policy on my other machine I used setsebool -P

>> then once I was able to get a clean boot(even with the "targeted" dbus
>> issue)
>> I focused in on the login context:
>> name:user_r:user_t
>>
>> this can be done in:
>> /etc/pam.d/{login,gdm,xdm}
>>
>> adding:
>> session required pam_selinux.so close
>> session required pam_selinux.so open
>> (suse has nothing of this in there files,
>> or atleast I didn't see them)
>
> So someone needs to file bugs against those packages asking to have the
> pam_selinux.so entries added.  Should be harmless if SELinux is
> disabled; they will just exit with success.
>

yeah I was surprised to not see them there.

>> so after adding all allow rules from dmesg/messages(audit2allow)
>> I then added all allow rules from /var/log/audit/audit.log
>> (there probably is a tool, but haven't figured what it is yet)
>
> Well, we ought to look at the actual denials to see if they truly should
> be allowed or if they instead indicate problems with your processes
> running in the wrong context or your files being mislabeled.
>

seemed like it was o.k., to me(but could be wrong).

there was I think three avc's that where defined as neverallow
in the policy.

an avc from hal which executed execmem to lower the gpu power level.
mount mounting the hard drive(if remember correctly).
and then a capability avc's

in the past running ubuntu I remember those three,if I can remember the 
next policy update had fixed those or later down the line.

BTW: just to let you know I took that image and reformatted it
and put on my system so I can start looking into a kernel bug
if you need me to reinstall let me know(should only take a few mins to 
get back where I was(now that I have a handle on whats happening)).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
