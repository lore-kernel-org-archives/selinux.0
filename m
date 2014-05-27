Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4RClFlF005892
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 08:47:15 -0400
Message-ID: <538489AD.9090205@tresys.com>
Date: Tue, 27 May 2014 08:48:45 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: The use of fscontext(iso9660_t)
References: <5382DCB2.3010400@gmail.com>
In-Reply-To: <5382DCB2.3010400@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/26/2014 02:18 AM, dE wrote:
> The obvious point of a type value for a certain FS is to restrict programs from doing things which are not allowed on that FS.
> 
> iso9660/UDF etc... is a RO FS. So writing on it should not be allowed. But I can write to files having this security context.
> 
> So what's the utility of, atleast iso9660_t?

Questions about Reference Policy should be asked on its list.

The purpose of iso9660_t is to provide a separate type for that media, not to reinforce the fact that the disks are read-only by policy.  By being a file type, certain domains can write to it since they can write to all file types.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
