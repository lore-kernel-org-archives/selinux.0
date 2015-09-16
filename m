Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8G3dFCv019176
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 23:39:15 -0400
Received: by pacfv12 with SMTP id fv12so199358285pac.2
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 20:39:13 -0700 (PDT)
Date: Wed, 16 Sep 2015 11:39:09 +0800
From: Jason Zaman <jason@perfinion.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Neverallow in http policy
Message-ID: <20150916033909.GA27516@meriadoc.perfinion.com>
References: <CA+=dQ-8o9gDb9s-Y2m5TzQ-m3yueq=aSOjJPhi2aoRD7r3+o3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+=dQ-8o9gDb9s-Y2m5TzQ-m3yueq=aSOjJPhi2aoRD7r3+o3w@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 16, 2015 at 12:10:42AM +0530, Divya Vyas wrote:
>    Hi,
>    How do I write a policy rule to stop http server reading /etc/passwd
>    file.
> neverallow ~can_read_shadow_passwords httpd_t:file read;
> 
>    Will this work?

That is not what neverallow statements do. If you want to remove the
ability for something to read a file,  you have to remove the allow
rule. There is no deny rule. Neverallow means there will instead be a
compile error if you try and add that rule. There should already be a
neverallow for shadow and you need to grant an exception.

But more importantly, have you checked that your http server is actually
allowed to read shadow? Almost nothing can.

sesearch -ACT -s httpd_t -t shadow_t

this will tell you all the perms that httpd can do on shadow. If file
read is not one of them you do not have to do anything.

-- Jason
