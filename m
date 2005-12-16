Message-ID: <43A30560.60605@us.ibm.com>
Date: Fri, 16 Dec 2005 12:20:16 -0600
From: "Daniel H. Jones" <hotrats@us.ibm.com>
MIME-Version: 1.0
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
   "Brian T. Sniffen" <bsniffen@mitre.org>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
Subject: Re: ANN: Virgil 0.1 released
References: <1134744996.3421.534.camel@moss-spartans.epoch.ncsc.mil> <200512161745.jBGHjDBn004256@mms-r00.iijmio.jp>
In-Reply-To: <200512161745.jBGHjDBn004256@mms-r00.iijmio.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:
> Stephen Smalley  wrote:
> 
>>Could you briefly summarize how you view this tool and work as differing
>>from:
>>- the SELinux Policy Editor project (http://seedit.sf.net),
> 
> 
> I've tried virgil 0.1 and found difference.
> 
> Our tool(SELinux Policy Editor) is intended to simplify entire policy, 
> and its Simplified Poilcy Description(SPDL) language can describe 
> full policy that works.
> However, policy converted from SPDL can not be appended to 
> existing policy(sample policy, reference policy), because name of types 
> are completely different.
> 
> On the other hand, 
> It seems that Virgil is intended to generate policy piece, appendable to existing policy.
> 
> 
>>Naturally, your tool will need to deal with the transition to reference
>>policy and the use of binary/loadable policy modules.
> 
> I thinks so too.
> The tool will be more useful if it could generate policy module package
> directly appendable to existing policy.
> 
> ---
> Yuichi Nakamura
> Japan SELinux Users Group(JSELUG)
> SELinux Policy Editor:  http://seedit.sourceforge.net/
> 
> 

Yes. Thank you Yuichi. I think you have it exactly right. One of the 
primary goals of Virgil was to integrate new policy with existing 
policy. While the example conf files include policy for httpd, it is not 
my intent to replace the shipped policy. Web servers just make very 
useful examples.

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
