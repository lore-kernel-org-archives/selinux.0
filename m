Message-ID: <1397590666.2471.5.camel@flatline.rdu.redhat.com>
Subject: Re: [PATCH] libsepol: Skip duplicate filename_trans rules in
 state->out policy.
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 15 Apr 2014 15:37:46 -0400
In-Reply-To: <534D865F.1080409@tycho.nsa.gov>
References: <1397579252-1378-1-git-send-email-richard_c_haines@btinternet.com>
 <534D6117.4020506@tycho.nsa.gov>	<534D78B6.9070208@tycho.nsa.gov>
 <1397586465.2471.2.camel@flatline.rdu.redhat.com>
 <534D7BA4.2040705@tycho.nsa.gov>
 <1397587423.2471.4.camel@flatline.rdu.redhat.com>
 <534D8385.9010908@tycho.nsa.gov>
 <CACLa4pu49Qhpyf8j_c3PE=fHySN_Tsf9PTaoZfR-TjiGB1nYKw@mail.gmail.com>
 <534D865F.1080409@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-15 at 15:19 -0400, Stephen Smalley wrote:
> On 04/15/2014 03:18 PM, Eric Paris wrote:
> > Why didn't it fail in the kernel on policy load?
> 
> AFAICS you aren't checking for conflicts (and are ignoring duplicates)
> in your kernel side code that loads the entries.

Oh right, that whole 'system wasn't booting' thing.  Which pointed out
this bug, and then I never fixed it.  Perfect.  Glad I've been
reminded...
