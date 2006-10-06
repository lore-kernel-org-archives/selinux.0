Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96AngNi020425
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 06:49:42 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k96An703023492
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 10:49:07 GMT
Message-ID: <452634C0.3010700@gentoo.org>
Date: Fri, 06 Oct 2006 06:49:36 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: Casey Schaufler <casey@schaufler-ca.com>,
        Linda Knippers <linda.knippers@hp.com>, paul.moore@hp.com,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com,
        vyekkirala@TrustedCS.com, jmorris@namei.org,
        Joy Latten <latten@austin.ibm.com>, eparis@parisplace.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
References: <4522EB42.9070502@hp.com> <20061003233848.21938.qmail@web36606.mail.mud.yahoo.com> <20061005224734.GA28520@w-m-p.com>
In-Reply-To: <20061005224734.GA28520@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Tue, Oct 03, 2006 at 04:38:48PM -0700, Casey Schaufler wrote:
>   
>> --- Linda Knippers <linda.knippers@hp.com> wrote:
>>     
>>> It has a requirement to be able to audit all modifications of the
>>> values of security attributes, so we can audit a bunch of syscalls
>>> that do that (chmod, chown, setxattr, ...).  Relabeling files would
>>> definitely count and be covered.  There's also a requirement about
>>> auditing changes to the way data is imported/exported, so this is
>>> where the networking stuff comes in.  I don't know about domain
>>> transitions.
>>>       
>> I think you would have trouble arguing that a domain transition is not
>> a change in the security state of the system. For the evaluations I
>> worked auditing was required for any change to uids, gids,
>> capabilities, sensitivity, integrity, or any other security relevent
>> attribute.
>>     
>
> Yes, it is a change in the process security state.
>
> Domain transitions are auditable already - dynamic transitions through
> the auditallow rules on /proc/$PID/attr/*, and automatic transitions by
> putting filesystem watches on the *_exec_t binaries you're interested in.
>
>   
Um, you can just auditallow domain domain : process transition for all 
transitions but the point was that they didn't want a mixture of policy 
auditing and audit framework auditing

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
