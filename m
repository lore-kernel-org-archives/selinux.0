Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6MNIxH7004155
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 19:18:59 -0400
Subject: Re: rpm running with MLS range?
To: Miroslav Grepl <mgrepl@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <b479402e-d234-676b-ea5e-33c7d966729f@redhat.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <80236005-3c53-0ffa-2d3e-550d766a581c@ieee.org>
Date: Fri, 22 Jul 2016 19:19:03 -0400
MIME-Version: 1.0
In-Reply-To: <b479402e-d234-676b-ea5e-33c7d966729f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/22/16 09:41, Miroslav Grepl wrote:
> Hi folks,
> we define a MLS range for some directories in the policy and because we
> have a SELinux support in rpm, we can end up with AVC msgs like
>
> type=AVC msg=audit(1461664028.583:784): avc:  denied  { relabelto } for
> pid=14322 comm="yum" name="libvirt" dev="dm-0" ino=670147
> scontext=root:system_r:rpm_t:s0
> tcontext=system_u:object_r:virt_cache_t:s0-s15:c0.c1023 tclass=dir
>
> Does it make sense to have rpm_t running with a range or should we think
> about a new MLS attribute for "file ( relableto )"?

Normally package managers aren't processing sensitive (in the MLS sense) 
data.  Creating objects higher than system low is an exceptional case, 
so I'd go with a new MLS exception (attribute).

-- 
Chris PeBenito
