Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s45BshLB020418
 for <selinux@tycho.nsa.gov>; Mon, 5 May 2014 07:54:43 -0400
Message-ID: <53677C2F.7020800@tresys.com>
Date: Mon, 5 May 2014 07:55:27 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: What's a module exactly?
References: <53665D05.6070403@gmail.com>
In-Reply-To: <53665D05.6070403@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2014 11:30 AM, dE wrote:
> I'm trying to verify what I think cause I've not read about this yet --
> 
> A SELinux 'module' is like a C object file; each module has a purpose of defining policies for a certain program.
> 
> Each module may be made a separate policy or many modules can be integrated into one policy file (like what Fedora has done).

If you're talking about modules as in .pp files, then yes, they're a similar concept to C object code.  Each module has a chunk of policy, and then all the modules are linked together to create the final policy.2x.  There has to be at least one module in the policy, the base module.  It is special in that all of the unconditional (not optional) dependencies must be met.  There are also statements that only can exist the base module, such as portcon, genfscon, and others.  Otherwise, what is actually contained in each module is up to the policy writer.  The modules tend to correspond to software packages.  For example, in Reference Policy, there is an apache module which should constrain apache, a samba module for samba, etc.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
