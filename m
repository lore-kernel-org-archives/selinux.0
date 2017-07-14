Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6ELvHil031290
 for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2017 17:57:18 -0400
Received: by mail-lf0-f54.google.com with SMTP id b207so60333938lfg.2
 for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2017 14:57:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500043990.26673.2.camel@tycho.nsa.gov>
References: <1499944132-6721-1-git-send-email-mmalik@redhat.com>
 <1499964819.624.8.camel@tycho.nsa.gov>
 <1385984548.51732700.1500018295331.JavaMail.zimbra@redhat.com>
 <1500043990.26673.2.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 14 Jul 2017 17:57:08 -0400
Message-ID: <CAHC9VhT8weFAvni9+HAb9oMQks33H+=VC-RJzXQLorZwyorBpg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Milos Malik <mmalik@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Additional tests for long-time supported netlink classes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 14, 2017 at 10:53 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I don't know if we care about distinguishing at the granularity of
> point releases of RHEL7 (e.g. RHEL7.2 vs RHEL7.3); we just want to
> ensure that the testsuite will pass on the latest release of RHEL7.

I think this is the right way to go about it the way the tests
currently work.  At some point we will probably want to provide some
better infrastructure for specifying different minor releases or
kernel revisions, but right now sticking with the latest minor release
seems reasonable.

-- 
paul moore
www.paul-moore.com
