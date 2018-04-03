From: jwcart2 <jwcart2@tycho.nsa.gov>
To: SELinux List <selinux@tycho.nsa.gov>,
 Refpolicy List <refpolicy@oss1.tresys.com>
Message-ID: <20bf510c-4ad7-63ec-fee3-fe0ee5c1d3af@tycho.nsa.gov>
Date: Tue, 3 Apr 2018 11:33:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: ANN: SELinux Policy Tools - selpoltools
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The selpoltools are a collection of policy tools for SELinux. It works on 
Refpolicy-based policies or a collection of policy files. Right now the only 
useful tool is spt_lint.lua.

You can find selpoltools at:
https://github.com/jwcart2/selpoltools

See README.md for the very simple build instructions and examples of usage.

spt_lint.lua can detect problems such as:
- Unused macro (interface and template) parameters
- Calls that have more or less arguments then needed
- Identifiers used in macros but not declared anywhere in policy
- Identifiers used in macros but not required by the macro
- Identifiers required in macros but not declared anywhere in policy
- Identifiers required in macros but not used in the macro
- Macros that will appear in policy even though their module is marked "off" in 
modules.conf.

See docs/spt_lint--warnings.txt for more details on the warnings that are reported.

I had previously created a tool to convert Refpolicy to CIL, but it required 
multiple patches to Refpolicy to work. selpoltools uses a different approach and 
only requires that "make conf" has been run (if running on a Refpolicy policy 
tree). I created this tool primarily to help me identify patterns in Refpolicy 
that have caused me problems in the past when converting to CIL. The main 
culprits being identifiers that are required but not used (for CIL everything 
used is required, but only what is used is required) and macros that appear in 
policy even though their module is turned off (so far only a problem with 
Fedora's policy).

I hope to eventually build upon this work to create a tool that can generate CIL 
from Refpolicy.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
