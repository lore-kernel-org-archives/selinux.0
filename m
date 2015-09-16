Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8G6bevS028989
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 02:37:40 -0400
Received: by pacex6 with SMTP id ex6so200421018pac.0
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 23:37:37 -0700 (PDT)
Date: Wed, 16 Sep 2015 14:37:27 +0800
From: Jason Zaman <jason@perfinion.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Neverallow in http policy
Message-ID: <20150916063727.GA13249@meriadoc.perfinion.com>
References: <CA+=dQ-8o9gDb9s-Y2m5TzQ-m3yueq=aSOjJPhi2aoRD7r3+o3w@mail.gmail.com>
 <20150916033909.GA27516@meriadoc.perfinion.com>
 <CA+=dQ-_Ga1mWTyp6D9R7mjdbkVjpoVsCm3_aUWCSuNzZBH=CgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+=dQ-_Ga1mWTyp6D9R7mjdbkVjpoVsCm3_aUWCSuNzZBH=CgQ@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 16, 2015 at 10:57:55AM +0530, Divya Vyas wrote:
>    Hi,
>    I dont want httpd_t to read etc_runtime_t tpe, If I remove read
>    operation from
>    below rules,will it work ?
>    sesearch -ACT -s httpd_t -t etc_runtime_t
>    allow httpd_t etc_runtime_t : file { ioctl read getattr lock open } ;
>    allow httpd_t etc_runtime_t : lnk_file { read getattr } ;
>    allow httpd_t file_type : filesystem getattr ;

Yes, that should work. I initially thought you wanted to remove access
to /etc/shadow since that is what the can_read_shadow_passwords
attribute is about but you said /etc/passwd above that.

Although make sure you test thoroughly, I suspect that apache needs to
be able to read /etc/passwd in order to drop privs down to the apache
user from root. Removing /etc/passwd access might not work at all.

-- Jason

>    On Wed, Sep 16, 2015 at 9:09 AM, Jason Zaman <[1]jason@perfinion.com>
>    wrote:
> 
>    On Wed, Sep 16, 2015 at 12:10:42AM +0530, Divya Vyas wrote:
>    >Â  Â  Hi,
>    >Â  Â  How do I write a policy rule to stop http server reading
>    /etc/passwd
>    >Â  Â  file.
>    > neverallow ~can_read_shadow_passwords httpd_t:file read;
>    >
>    >Â  Â  Will this work?
> 
>      That is not what neverallow statements do. If you want to remove the
>      ability for something to read a file,Â  you have to remove the allow
>      rule. There is no deny rule. Neverallow means there will instead be
>      a
>      compile error if you try and add that rule. There should already be
>      a
>      neverallow for shadow and you need to grant an exception.
>      But more importantly, have you checked that your http server is
>      actually
>      allowed to read shadow? Almost nothing can.
>      sesearch -ACT -s httpd_t -t shadow_t
>      this will tell you all the perms that httpd can do on shadow. If
>      file
>      read is not one of them you do not have to do anything.
>      -- Jason
> 
> References
> 
>    1. mailto:jason@perfinion.com
