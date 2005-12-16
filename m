Message-Id: <200512161745.jBGHjDBn004256@mms-r00.iijmio.jp>
Date: Fri, 16 Dec 2005 12:45:01 -0500
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Daniel H. Jones" <hotrats@us.ibm.com>,
   "Brian T. Sniffen" <bsniffen@mitre.org>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: Re: ANN: Virgil 0.1 released
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1134744996.3421.534.camel@moss-spartans.epoch.ncsc.mil>
References: <1134744996.3421.534.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley  wrote:
> Could you briefly summarize how you view this tool and work as differing
> from:
> - the SELinux Policy Editor project (http://seedit.sf.net),

I've tried virgil 0.1 and found difference.

Our tool(SELinux Policy Editor) is intended to simplify entire policy, 
and its Simplified Poilcy Description(SPDL) language can describe 
full policy that works.
However, policy converted from SPDL can not be appended to 
existing policy(sample policy, reference policy), because name of types 
are completely different.

On the other hand, 
It seems that Virgil is intended to generate policy piece, appendable to existing policy.

> Naturally, your tool will need to deal with the transition to reference
> policy and the use of binary/loadable policy modules.
I thinks so too.
The tool will be more useful if it could generate policy module package
directly appendable to existing policy.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
