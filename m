From: Victor Porton <porton@narod.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <52D04048.60607@tycho.nsa.gov>
References: <23731389285461@web11j.yandex.ru> <52CEF794.3030501@tycho.nsa.gov>
 <39121389295897@web13m.yandex.ru> <52CEF9C2.1080903@tycho.nsa.gov>
 <51901389379280@web5j.yandex.ru> <52D04048.60607@tycho.nsa.gov>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <66771389380012@web5j.yandex.ru>
Date: Fri, 10 Jan 2014 20:53:32 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

10.01.2014, 20:48, "Stephen Smalley" <sds@tycho.nsa.gov>:
> On 01/10/2014 01:41 PM, Victor Porton wrote:
>
>> š09.01.2014, 21:35, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>> šOn 01/09/2014 02:31 PM, Victor Porton wrote:
>>>> šš09.01.2014, 21:25, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>>>> ššOn 01/09/2014 11:37 AM, Victor Porton wrote:
>>>>>> šššI remind that sandbox is implemented in Fedora using SELinux.
>>>>>>
>>>>>> šššIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>>>
>>>>>> šššIt seems it is impossible with current SELinux.
>>>>>>
>>>>>> šššCould you add necessary features? Please!
>>>>> ššI'm not aware of any missing kernel features required to support your
>>>>> ššfunctionality. šI think all you are missing is two userspace components:
>>>> ššAFAIK, there are no support for this in Linux kernel.
>>>>
>>>> ššIt is why I advise to add a new syscall (see my previous message).
>>>>> ššša library that provides whatever interface you design, and a daemon
>>>>> ššthat receives the specification in whatever form you design and turns it
>>>>> ššinto a set of SELinux and iptables SECMARK/CONNSECMARK rules to label
>>>>> ššthe packets so that SELinux can mediate them accordingly, and loads that
>>>>> ššinto the kernel for enforcement.
>>>> ššI've already explained some reasons why iptables solution would be wrong. One of the reasons is that this would confuse a system administrator by appearance of new unexpected rules, the automatically added rules would also disappear when iptables script is reloaded, what could make errors for regular users. To use iptables this way seems a really bad idea.
>>> šFor SECMARK/CONNSECMARK, there is a separate dedicated security table to
>>> šavoid such conflicts.
>> šWe need to make a separate ID for every sandbox process (with all its children) (there may be more than one, even run simultaneously by the same user). This ID should be in some way passed to NetFilter. Does iptables provide a way to add such an ID to the rules? (Moreover we need to somehow ensure that this ID would not interact with rules created by other software packages or by an administrator?)
>>
>> šCan it be safely done with iptables? Please be specific.
>
> SECMARK/CONNSECMARK is just a way to assign a SELinux security context
> to packets based on various iptables selectors. šThen in SELinux policy,
> you can control sending/receiving packets based on those security
> contexts and the security context of the sending/receiving process. šYou
> can obviously generate a unique security context for each sandbox; the
> sandbox program already does that.

I understand this.

I just want to make sure that my daemon would be able to remove rules created by particular sandbox (when the sandbox exists). Can it be done by `iptables -D` with a complete security content (including the category, which is different for each sandbox)? I am not sure whether -D will deal with rules specified by (among other data) security context. Or can my daemon get specific rulenum for each rule it creates (to be able to remove them when the sandbox exists)?

-- 
Victor Porton - http://portonvictor.org
