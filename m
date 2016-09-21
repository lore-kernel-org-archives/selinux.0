MIME-Version: 1.0
In-Reply-To: <883e1b35-467e-e3dd-5baa-1822ab003829@tycho.nsa.gov>
References: <883e1b35-467e-e3dd-5baa-1822ab003829@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 21 Sep 2016 08:40:26 -0700
Message-ID: <CAFftDdqgu0dNoetJXiRCVZ6uK_Qd4U+0xo2jTj=pscQAy48UWw@mail.gmail.com>
Subject: Re: selinux 2.6-rc1 release planned 9/30
To: Stephen Smalley <sds@tycho.nsa.gov>, Janis Danisevskis <jdanis@google.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'd like to see the -r flip change in by then, so no official release
is cut with that behavior.

Also, I was looking at the help output for -r, and its quite
confusing, I cant tell if -r includes or omits, verbatim output:

-r       Include precompiled regular expressions in the output.
        (PCRE2 only. Compiled PCRE2 regular expressions are
        not portable across architectures. When linked against
        PCRE this flag is ignored)
        Omit precompiled regular expressions (only meaningful
        when using PCRE2 regular expression back-end).
fc_file  The text based file contexts file to be processed.




On Wed, Sep 21, 2016 at 7:37 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Hi,
>
> We plan to cut a 2.6-rc1 release on 9/30.  If you have any patches that
> you want included in 2.6, please post them to the list before then.
>
> Thanks.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
