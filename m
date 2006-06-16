Subject: Re: [PATCH] selinux: add /proc/pid/attr/keycreate
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: dhowells@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        jmorris@redhat.com
Content-Type: text/plain
Date: Fri, 16 Jun 2006 08:27:17 -0400
Message-Id: <1150460837.4368.3.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had previously used security_key_alloc because I moved that code from
another portion of the kernel, where it would have worked for all LSM
modules.  However, now that it's in the SELinux initialization routine,
there's no need to invoke the generic routine.  If you think that's
confusing I can change it back, it's all inlined anyway.

David Howells wrote: 
> Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> 
> > -	security_key_alloc(&root_user_keyring, current);
> > -	security_key_alloc(&root_session_keyring, current);
> > +	selinux_key_alloc(&root_user_keyring, current, 1);
> > +	selinux_key_alloc(&root_session_keyring, current, 1);
> 
> Is that right?
> 
> David
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
