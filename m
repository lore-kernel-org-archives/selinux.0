Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9QL7hig028846
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 17:07:44 -0400
Received: by mail-ua0-f169.google.com with SMTP id 6so12912858uat.0
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 14:07:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b2df6e05-1354-2ec0-178d-01b92cc1db85@schaufler-ca.com>
References: <b2df6e05-1354-2ec0-178d-01b92cc1db85@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Oct 2016 17:07:41 -0400
Message-ID: <CAHC9VhSkxvHQXiQ6s5_=k8Oer-wd2thnLEoq9RM9OvZggVqXXw@mail.gmail.com>
Subject: Re: Mapping of subject context to CIPSO
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 26, 2016 at 1:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> I am looking for a way to dump the mapping of
> a process context to its associated CIPSO representation.
> I could hack a kernel to do this, but if there's an
> obvious way to do it already I'd rather not.

The netlabelctl(8) tool is your friend:

* Mapping inbound DOIs
# netlabelctl -p cipsov4 list [doi:<DOI>]

* Mapping SELinux labels to CIPSO/unlabeled/etc.
# netlabelctl -p map list

Check the man page for more information.

I'll also be releasing a new netlabel_tools package soon which will
add CALIPSO support.

-- 
paul moore
www.paul-moore.com
