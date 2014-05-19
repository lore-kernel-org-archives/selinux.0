Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4JGrg7s025060
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 12:53:42 -0400
Message-ID: <537A3754.3020506@tresys.com>
Date: Mon, 19 May 2014 12:54:44 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: How does SELinux work without roles?
References: <537992DF.9050806@gmail.com>
In-Reply-To: <537992DF.9050806@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/19/2014 01:13 AM, dE wrote:
> RBAC is completely optional in SELinux; however there appears to be no way to specify the allowed types for a particular user without specifying roles.
> 
> Without this, there'll be no enforcement.

You still need to have user->role and role->type associations, but you can simply have one role and remove any constraints related to roles.  You cannot completely disable the RBAC mechanism like you can disable MLS.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
