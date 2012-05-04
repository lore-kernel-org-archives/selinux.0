Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44FiIp9005238
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 11:44:18 -0400
Received: by lbbgk8 with SMTP id gk8so2323433lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 04 May 2012 08:44:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336140013.24121.13.camel@moss-pluto>
References: <CADyhKSVyfCxx9dAziaR0bcbPvXW4C6FnV4J-Jux7gaMrT+-L+g@mail.gmail.com>
	<1336140013.24121.13.camel@moss-pluto>
Date: Fri, 4 May 2012 17:44:17 +0200
Message-ID: <CADyhKSUTP2xpjDW1GbFeYm-pQpDSqpX5bvRvid=1xfzrXw3DjQ@mail.gmail.com>
Subject: Re: regression test of security policy
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Stephen Smalley <sds@tycho.ncsc.mil>
Cc: SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

2012/5/4 Stephen Smalley <sds@tycho.ncsc.mil>:
> On Fri, 2012-05-04 at 15:48 +0200, Kohei KaiGai wrote:
>> Does anyone have a tool to run regression test when we construct a patch?
>> (Or, is it available to construct using existing tools?)
>>
>> Right now, I have to replace a working policy by the modified one whenever
>> I prepare to submit a patch towards reference policy. However, the default
>> security policy of Fedora is optimized to Fedora environment, thus, it often
>> mismatch with the latest upstream policy.
>> For example, "allow_execmem" is not defined at Fedora, so, I could not
>> load the staff.pp being constructed based on the upstream policy
>>
>> So, the solution I'm looking for is a tool that loads a monolithic policy and
>> checks its access control decision towards a certain pair of subject context
>> and target context according to catalog files, then it prints the result of
>> diff commands between the computed one and expected one.
>
> Possibly you could derive such a tool from checkpolicy -d, switching
> from a menu-driven interface to a scriptable one.
>
> checkpolicy -Mdb /etc/selinux/targeted/policy/policy.24
>
> setools would be the other option, but sesearch only deals with TE
> rules.
>
Thanks for your suggestion. I totally agree with the idea to expand
checkpolicy to accept a script that describes a set of patterns to be
checked. I'll try to investigate it in this weekend.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
