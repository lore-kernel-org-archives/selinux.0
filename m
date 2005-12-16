Message-ID: <43A3043E.60207@us.ibm.com>
Date: Fri, 16 Dec 2005 12:15:26 -0600
From: "Daniel H. Jones" <hotrats@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: ANN: Virgil 0.1 released
References: <43A1975B.5080702@us.ibm.com> <1134744996.3421.534.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1134744996.3421.534.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2005-12-15 at 10:18 -0600, Daniel H. Jones wrote:
> 
>>ANNOUNCEMENT
>>
>>Virgil 0.1 has been released and may be downloaded from:
>>http://sourceforge.net/projects/sepolicy-virgil/
>>
>>About Virgil
>>Virgil is a utility for generating SELinux policy for user domains not 
>>covered by the distributed policy packages. The Virgil GUI allows a 
>>policy creator to select options and identify file system resources, 
>>then generate the desired source policy files.
>>
>>Purpose
>>The goal is Virgil is to encourage adoption of SELinux by providing a 
>>relatively simple mechanism for creating policy. In order to achieve 
>>that goal, Virgil hides much of the complexity, and therefore 
>>flexibility, of SELinux. This trade-off makes Virgil unsuitable for 
>>creating "least privilege" policies. Nevertheless, Virgil is capable of 
>>creating useful SELinux policy that will enhance the security of 
>>programs for which no policy currently exists.
>>
>>For feedback please e-mail sepolicy-virgil-list@lists.sourceforge.net
> 
> 
> Hi,
> 
> Could you briefly summarize how you view this tool and work as differing
> from:
> - the SELinux Policy Editor project (http://seedit.sf.net),
> - the MITRE polgen tool (http://www.mitre.org/tech/selinux/),
> - the Tresys SEFramework (not yet publically released, but briefly
> described in http://tresys.com/selinux/sedev.shtml and presented at last
> year's SELinux Symposium
> 
> It would be nice to have more synergy among policy
> generation/development efforts.
> 
> Naturally, your tool will need to deal with the transition to reference
> policy and the use of binary/loadable policy modules.
> 

Hello,
If I were to create a mission statement for Virgil it would be:
* Provide SELinux policy for user domains that will coexist with 
existing shipped policy.

If it helps, I will make some comparisons to the policy tools mentioned 
above, but my comments should in no way be taken to imply the existing 
tools are deficient. I simply have a different user in mind. My target 
user is looking to include their custom domain to the shipped policy, 
and do it today.

SELinux Policy Editor (seedit)
This one comes closest to Virgil as far as I could tell from the 
documentation. However, this tool seems more suitable for replacement of 
the shipped policy, rather than integration. It looks to me like adding 
a "deny /blah/blah/blah" in the global domain could cause files to be 
relabeled in such a way that the shipped policy is affected.

By contrast, Virgil has the concept of "private" resources. Virgil only 
labels/relabels private file system objects which, by definition, are 
exclusive to the domain. Access to system (or non-private) resources is 
achieved by obtaining the label from the object.

Mitre polgen
The difference here is the top-down versus bottom-up approach. Virgil 
(as well as seedit) generate policy based on user specified criteria. 
Polgen generates policy based on program behavior (and some 
interaction). These are philosophically different approaches.

Tresys SEFramework
The most notable difference here is that Virgil is available as of 
yesterday. The SEFramework will no doubt be an industrial strength 
solution once it is released. The Tresys efforts are very forward 
looking and will change the SELinux policy development/management 
landscape. That's a good thing. In the meantime, however, a practical 
tool that can extend existing policy and be accessible to Joe Fedora is 
good for early SELinux adoption. It should not be construed as a 
competing technology.

The reference policy and loadable modules will need to be dealt with ... 
naturally.

As always, thanks for your constructive observations and comments.

-- 
Thanks,
Dan Jones
IBM Linux Technology Center, Security
512-838-1794 (T/L 678-1794)
hotrats@us.ibm.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
