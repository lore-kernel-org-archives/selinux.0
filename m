Subject: Re: ANN: Virgil 0.1 released
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Daniel H. Jones" <hotrats@us.ibm.com>
Cc: Yuichi Nakamura <himainu-ynakam@miomio.jp>,
   "Brian T. Sniffen" <bsniffen@mitre.org>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <43A1975B.5080702@us.ibm.com>
References: <43A1975B.5080702@us.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 09:56:36 -0500
Message-Id: <1134744996.3421.534.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-15 at 10:18 -0600, Daniel H. Jones wrote:
> ANNOUNCEMENT
> 
> Virgil 0.1 has been released and may be downloaded from:
> http://sourceforge.net/projects/sepolicy-virgil/
> 
> About Virgil
> Virgil is a utility for generating SELinux policy for user domains not 
> covered by the distributed policy packages. The Virgil GUI allows a 
> policy creator to select options and identify file system resources, 
> then generate the desired source policy files.
> 
> Purpose
> The goal is Virgil is to encourage adoption of SELinux by providing a 
> relatively simple mechanism for creating policy. In order to achieve 
> that goal, Virgil hides much of the complexity, and therefore 
> flexibility, of SELinux. This trade-off makes Virgil unsuitable for 
> creating "least privilege" policies. Nevertheless, Virgil is capable of 
> creating useful SELinux policy that will enhance the security of 
> programs for which no policy currently exists.
> 
> For feedback please e-mail sepolicy-virgil-list@lists.sourceforge.net

Hi,

Could you briefly summarize how you view this tool and work as differing
from:
- the SELinux Policy Editor project (http://seedit.sf.net),
- the MITRE polgen tool (http://www.mitre.org/tech/selinux/),
- the Tresys SEFramework (not yet publically released, but briefly
described in http://tresys.com/selinux/sedev.shtml and presented at last
year's SELinux Symposium

It would be nice to have more synergy among policy
generation/development efforts.

Naturally, your tool will need to deal with the transition to reference
policy and the use of binary/loadable policy modules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
