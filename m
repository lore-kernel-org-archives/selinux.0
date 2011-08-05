Message-ID: <4E3B6F5B.40904@windriver.com>
Date: Fri, 5 Aug 2011 12:19:39 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh
	<dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SELinux
	<selinux@tycho.nsa.gov>
Subject: Re: checkpolicy is broken (which is not)
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com> <4E3B441A.1090900@windriver.com> <4E3B5593.7000502@redhat.com>
In-Reply-To: <4E3B5593.7000502@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric,

Let me explain more about the background story.

The existing type rule could declare a type, and optionally associate it
with a list of type attributes. So I invented this "role <regular role>
attribute <a list of role attributes>" rule in the same manner to do the
similar things for roles, since I figure this would make refpolicy rules
similar and easy to remember and use.

Now that the above new role-attr rule takes care of declaring roles,
this duty has to be removed from role-type rule in order to avoid
ambiguity, and the role-type rule would be used to only associate types
with roles, which only requires TWO lines of code as in 3cbc9727, since
mostly used roles such as system_r have been declared in kernel.te(in
order to avoid some build failure).

In a word, we could preserve the behavior of role-type rule, but this
would introduce discrepancy between that of role-attr rule and type-attr
rule, considering that getting used to the new toolchain only requires
an easy cherry-pick of only 2 lines of change, would it be that
desirable for us to do so?

Thanks,
Harry



Eric Paris 写道:
> On 08/04/2011 09:15 PM, Harry Ciao wrote:
>   
>> Hi Chris,
>>
>> I think Dan's case below is a good example, that while
>> libsepol/checkpolicy/etc upgraded to 2011-07-27 release, people may have
>> not upgraded(or don't want/need to for the time being) the refpolicy to
>> the 2011-07-26 release accordingly, then people would run into this problem.
>>
>> I am wondering if there is a need to add one note in selinux project
>> wiki page that once upgraded to 2011-07-27 release, at least the
>> 3cbc9727 commit should be cherry-picked to refpolicy, if people still
>> prefer to older releases.
>>     
>
> I don't think we can/should do this.  New userspace should be able to
> handle old policy.  You understand this code better than anyone, can you
> find a solution such that old modules will still compile and work?
>
> -Eric
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
