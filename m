Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TK9S4E029171
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:09:28 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TKATF5018047
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 20:10:30 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l0TK5ClK005324
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:05:12 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l0TK5CFm005323
	for selinux@tycho.nsa.gov; Mon, 29 Jan 2007 15:05:12 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org
Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net>
	<20070127172410.2b041952.akpm@osdl.org>
	<1169972718.17469.164.camel@localhost.localdomain>
	<20070128003549.2ca38dc8.akpm@osdl.org>
	<20070128093358.GA2071@elte.hu> <20070128095712.GA6485@elte.hu>
	<20070128100627.GA8416@elte.hu>
	<20070128104548.a835d859.akpm@osdl.org>
	<m1r6tfq7nv.fsf_-_@ebiederm.dsl.xmission.com>
	<1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil>
Date: Mon, 29 Jan 2007 10:43:07 -0700
In-Reply-To: <1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 29 Jan 2007 08:04:26 -0500")
Message-ID: <m18xflloes.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On Sun, 2007-01-28 at 12:21 -0700, Eric W. Biederman wrote:
>> With the sysctl cleanups sysctl is not really a part of proc
>> it just shows up there, and any path based approach will not
>> adequately describe the data as sysctl is essentially a
>> union mount underneath the covers.  As designed this mechanism
>> is viewer dependent so trying to be path based gets even worse.
>> 
>> However the permissions in sys_sysctl are currently immutable
>> and going through proc does not change the permission checks
>> when accessing sysctl.  So we might as well stick with the well
>> defined sysctl sid, as that is what selinux uses when proc is
>> not compiled in.
>> 
>> I.e.  I see no hope for salvaging the selinux_proc_get_sid call
>> in selinux_sysctl so I'm removing it.
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>>  security/selinux/hooks.c |    8 ++------
>>  1 files changed, 2 insertions(+), 6 deletions(-)
>> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 7b38372..3a36057 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -1438,12 +1438,8 @@ static int selinux_sysctl(ctl_table *table, int op)
>>  
>>  	tsec = current->security;
>>  
>> -	rc = selinux_proc_get_sid(table->de, (op == 001) ?
>> -	                          SECCLASS_DIR : SECCLASS_FILE, &tsid);
>> -	if (rc) {
>> -		/* Default to the well-defined sysctl SID. */
>> -		tsid = SECINITSID_SYSCTL;
>> -	}
>> +	/* Use the well-defined sysctl SID. */
>> +	tsid = SECINITSID_SYSCTL;
>>  
>>  	/* The op values are "defined" in sysctl.c, thereby creating
>>  	 * a bad coupling between this module and sysctl.c */
>
> NAK.  Mapping all sysctls to a single security label prevents any kind
> of fine-grained security on sysctls, and current policies already make
> use of the current distinctions to limit access to particular sets of
> sysctls to particular processes.  As is, I'd expect breakage of current
> systems running SELinux from this patch, because (confined) processes
> that formerly only required access to specific sysctl labels will
> suddenly run into denials on the generic fallback label.

Reasonable.  There is the issue that your code already had this code
path for when /proc was compiled out.

> If the ctl_table supplied more information about the functional purpose
> and the security sensitivity of the sysctl, then we could leverage that
> information instead, as long as we can at least derive the current
> labelings from that information for compatibility.

What do information do you need to do need?  Do you need extra fields in sysctl?
I am more than willing to help but I am not familiar enough with selinux
to do a reasonable job on my own.

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
