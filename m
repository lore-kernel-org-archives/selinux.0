Subject: Re: ssh/xinetd/getpeercon???
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: vyekkirala@TrustedCS.com, redhat-lspp@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1171495601.2603.488.camel@faith.austin.ibm.com>
References: <1171495601.2603.488.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 13:43:20 -0500
Message-Id: <1171565000.32574.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 17:26 -0600, Joy Latten wrote:
> I have been playing with the ssh-mls which gets called through xinetd
> when labeled networking is in use and am confused about what I am
> seeing. :-)
> 
> My assumption is that when using this feature, the resulting ssh
> connection will have single mls level, which is the effective level of
> the issuer. 
> 
> For example, if I am
> uid=500(ealuser) gid=500(ealuser) groups=10(wheel),500(ealuser)
> context=staff_u:staff_r:staff_t:s3-s9
> 
> When I issue ssh -p 222 -l <user> <host>, I expect to see "s3" as my new
> mls level in the new ssh connection when I do an "id".
> 
> With CIPSO, this happens.
> With labeled ipsec, I get "s3-s9".
> 
> Debugging xinetd, I noticed that when using CIPSO, getpeercon() returns 
> "system_u:object_r:unlabeled_t:s3".
> 
> When using labeled ipsec, getpeercon() returns
> "root:sysadm_r:sysadm_ssh_t:s3-s9".
> 
> I always wondered if getpeercon() would someday lift its head and bite,
> I just wish it had not been on Valentine's Day. :-)
> I am concerned about the mls label being returned.
> 
> So, my question is, how is this suppose to work?
> Does CIPSO, when given an mls range, like s3-s9, only pass
> the effective level through in ip options? If so, is this 
> what labeled ipsec should be doing? Should we be setting only the 
> effective level in the SA? If so, that could potentially create 
> even more SAs. Or should xinetd, when given a range, should only
> set the effective level for the new process? I kinda like this 
> solution best, that is, xinetd setting single effective level. But
> I don't know if that is correct resolution? 

The labeled networking mechanism should convey the full context when
possible (naturally, with a legacy mechanism like CIPSO, we may not have
that option except by using something like James Morris' Selopt
approach, which naturally won't be compatible with legacy trusted OSes).
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
