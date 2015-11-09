Subject: Re: neverallow rules and self negation
To: Nick Kralevich <nnk@google.com>, SELinux <Selinux@tycho.nsa.gov>
References: <CAFJ0LnG+=byi92+d6EWyJDikgxxUjX8E1WAHbu4ZBix-65mMYw@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5640ADA7.8030801@tycho.nsa.gov>
Date: Mon, 9 Nov 2015 09:28:55 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnG+=byi92+d6EWyJDikgxxUjX8E1WAHbu4ZBix-65mMYw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/07/2015 11:29 PM, Nick Kralevich wrote:
> Consider the following rules:
>
>    attribute foo;
>    type asdf, foo;
>    type asdf2, foo;
>    allow asdf self:dir search;
>    neverallow foo { foo -self }:dir search;
>
> This particular policy fails to compile with the following error:
>
> libsepol.report_failure: neverallow on line XXX of XXX (or line XXX of
> policy.conf) violated by allow asdf asdf:dir { search };
> libsepol.check_assertions: 1 neverallow failures occurred
>
> The intent of the neverallow rule is to prohibit cross domain access
> to some resource, but allow access within the same domain. Something
> like:
>
>    neverallow asdf { foo -asdf }:dir search;
>    neverallow asdf2 { foo -asdf2 }:dir search;
>
> 1) Is the behavior described above a bug or working as intended?
> 2) Is there a way to write a neverallow rule where the target uses
> "-self", and if so, what does it mean?

It doesn't look to me as if "-self" has ever been supported correctly 
either by the checkpolicy parser or by the libsepol neverallow/assertion 
checker.  So, it's a bug, but not sure how involved a fix will be 
(beyond just having checkpolicy reject it in the first place).
