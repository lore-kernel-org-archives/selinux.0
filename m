Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s68CNug2032477
 for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2014 08:23:56 -0400
Message-ID: <53BBE2CB.4000903@tresys.com>
Date: Tue, 8 Jul 2014 08:23:39 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: What's a 'permission map'?
References: <53BB794B.7070206@gmail.com>
In-Reply-To: <53BB794B.7070206@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/8/2014 12:53 AM, dE wrote:
> This seems to be required by apol sometimes. Loading the default policy
> as the permission map works, but what is permission map?

In apol, it is required by an information flow analysis.  A permission
map describes each permission in the policy as an abstract "read",
"write", "both", or "none" information flow permission used in the
analysis.  The apol help text has a full description of information flow
analysis and the permission map (Help->Information Flow Analysis).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
