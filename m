Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SFjgAU020772
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 11:45:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SFj8Xf016268
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 15:45:08 GMT
Message-ID: <451BEE24.7040609@redhat.com>
Date: Thu, 28 Sep 2006 11:45:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs.  Trimmed down this time.
References: <45183220.8090106@redhat.com> <1159454177.2850.9.camel@sgc.columbia.tresys.com>
In-Reply-To: <1159454177.2850.9.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Merged.
>
> On Mon, 2006-09-25 at 15:46 -0400, Daniel J Walsh wrote:
>   
>> Corrected oddjob policy
>>     
>
> The mkhomedir policy looks incomplete.
>
>   
Yes it needs more testing.
> fixed the stray 
>
> domain_auto_trans(unconfined_t,oddjob_mkhomedir_exec_t,oddjob_mkhomedir_t)
>
> in the module.
>
>   
>> Doesn't ssh need
>> +       userdom_search_all_users_home_dirs(sshd_t)
>>     
>
> See my response to Erich.
>
>   
I removed this.
>> Cups init script wants to clear the error_log
>>     
>
> Does initrc_t need read on this still?
>
>   
I don't think so.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
