Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uADIuPMB005155
 for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2016 13:56:25 -0500
Subject: Re: [Patch v2 2/2] policycoreutils: Make sepolicy work with python3
To: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <20161107080117.24030-2-bigon@debian.org>
 <20161107095108.22306-1-bigon@debian.org>
 <21527c6a-410d-d819-2e43-a90b2d757694@tycho.nsa.gov>
 <0218ca49-6e92-33e0-cb29-4a792c1b5b7c@tycho.nsa.gov>
 <7ce6bf50-c7e4-965f-e9df-eb5a3d4249dc@ieee.org>
 <CAJfZ7=k_gUHD1mOA449avb4-J57WM7if6g6QKa+HXAnoQOq7NA@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>,
 selinux <selinux@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <c15454f3-bf20-0878-8305-620a2130bb29@ieee.org>
Date: Sun, 13 Nov 2016 13:56:21 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=k_gUHD1mOA449avb4-J57WM7if6g6QKa+HXAnoQOq7NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/13/16 11:20, Nicolas Iooss wrote:
> On Fri, Nov 11, 2016 at 1:58 AM, Chris PeBenito <pebenito@ieee.org
> <mailto:pebenito@ieee.org>> wrote:
>     On 11/08/16 10:29, Stephen Smalley wrote:
>         Oh, I guess it is just very slow with setools4.  It did finally
>         complete
>         sepolicy network -d and has moved on (next slow/hanging one is
>         transition -t).
>     Yes, sadly setools4 is slower.  I haven't spent much time on trying
>     to improve the performance yet (preliminary profiling seems to
>     indicate that swig is the problem).  However, looking through the
>     sepolicy code, I found that it could use the setools code more
>     efficiently (I realize the first matter of business was just to get
>     it over to setools4).
>
>     The biggest win will be to minimize how many times the code iterates
>     over all TE rules.  For example, in the search function, it runs the
>     TERuleQuery twice, when it could be done in one query.  Also, for
>     the transition command, it seems to manually implement a domain
>     transition analysis.  When I compared the sepolicy transition run
>     time to sedta, sedta was a minute faster for the same analysis.
>
>
> A few months ago (in August) I did some profiling on sesearch (from
> SETools 4) and found that a lot of time was spent in SWIG casting
> operations (like qpol_avrule_from_void). A quick patch to remove a cast
> (https://github.com/fishilico/setools/commit/461bf0297b950ae40ba5bcb17db0f2a19f14d560)
> made sesearch quite faster (I don't have the precise numbers here).
> In short I believe the way the SWIG wrappers use objects (and create
> objects from pointers) causes a noticeable performance impact, and I
> have no opinion on what would be the best approach to improve the code.

I've also been considering transitioning out of SWIG into cython. 
There's no need to support anything other than Python, it's much less 
magical than SWIG and easier to understand.  Unfortunately that will 
take some effort.

-- 
Chris PeBenito
