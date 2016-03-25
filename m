Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2P6lWTT006367
 for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2016 02:47:33 -0400
In-Reply-To: <CAJfZ7=ktGwNiHc7WWBLp6J7HOXszMoB2F9MQuEDFqu7N9fj1qw@mail.gmail.com>
References: <201602050832.20068.russell@coker.com.au>
 <56B4E9F1.8070904@tycho.nsa.gov> <201602061258.00611.russell@coker.com.au>
 <CAJfZ7=ktGwNiHc7WWBLp6J7HOXszMoB2F9MQuEDFqu7N9fj1qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: selinux_set_callback() problem
From: Russell Coker <russell@coker.com.au>
Date: Fri, 25 Mar 2016 17:47:00 +1100
To: Nicolas Iooss <nicolas.iooss@m4x.org>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <A6416E52-15BE-40E8-9E35-E722E939EA42@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for pointing that out. I was using Debian/Jessie (which is older than that) and I've now backported systemd from Debian/Unstable for Jessie which solves that problem and has some other SE Linux fixes.

On February 6, 2016 9:58:11 PM GMT+11:00, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>On Sat, Feb 6, 2016 at 2:58 AM, Russell Coker <russell@coker.com.au>
>wrote:
>
>> On Sat, 6 Feb 2016 05:29:05 AM Stephen Smalley wrote:
>> > On 02/04/2016 04:32 PM, Russell Coker wrote:
>> > > type=USER_AVC msg=audit(1454447396.743:48359): pid=1 uid=0
>> > > auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
>> > > msg='avc:  denied  { status } for auid=0 uid=0 gid=0
>> > > path="/lib/systemd/system/reboot.target"
>> > > cmdline="reboot"
>> > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>> > > tcontext=system_u:object_r:systemd_unit_file_t:SystemLow
>tclass=service
>> > > exe="/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'
>> > >
>> > > I'm seeing entries like the above from the Debian/Jessie systemd
>in
>> > > audit.log. Below is the relevant code from the systemd source:
>> > >
>> > > _printf_(2, 3) static int log_callback(int type, const char *fmt,
>...)
>> {
>> > >
>> > >          va_list ap;
>> > >
>> > > #ifdef HAVE_AUDIT
>> > >
>> > >          if (get_audit_fd() >= 0) {
>> > >
>> > >                  _cleanup_free_ char *buf = NULL;
>> > >                  int r;
>> > >
>> > >                  va_start(ap, fmt);
>> > >                  r = vasprintf(&buf, fmt, ap);
>> > >                  va_end(ap);
>> > >
>> > >                  if (r >= 0) {
>> > >
>> > >                         
>audit_log_user_avc_message(get_audit_fd(),
>> > >
>> > > AUDIT_USER_AVC, buf,
>> > > NULL, NULL, NULL, 0);
>> > >
>> > >                          return 0;
>> > >
>> > >                  }
>> > >
>> > >          }
>> > >
>> > > #endif
>> > >
>> > >          va_start(ap, fmt);
>> > >          log_metav(LOG_USER | LOG_INFO, __FILE__, __LINE__,
>> __FUNCTION__,
>> > >          fmt,
>> > >
>> > > ap);
>> > >
>> > >          va_end(ap);
>> > >
>> > >          return 0;
>> > >
>> > > }
>> > >
>> > > Then the following line is in the access_init() function to
>enable it:
>> > >
>> > > selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback)
>> > > log_callback);
>> > >
>> > > Any suggestions as to where I should start working on this?
>> > >
>> > > Sorry if it's a newbie question, I haven't worked on SE Linux
>library
>> > > code for a while.
>> >
>> > What exactly is the problem?  Is it that the scontext has a raw
>context
>> > and the tcontext has a translated context?  Or is it that it was
>denied
>> > when it should have been allowed?
>> >
>> > The callback itself is obviously being executed or you wouldn't
>have the
>> > audit message at all.
>>
>> The problem is a translated context which breaks audit2allow.  Even
>if it
>> didn't break audit2allow it wouldn't be a good thing to have as the
>text
>> representations can (in theory at least) change.
>
>
>In systemd git log, there is
>https://github.com/systemd/systemd/commit/24154879845c6aa68a82d3a606f037e9df7527e0
>which seems to fix this issue for systemd >=226. Nevertheless there may
>have been a regression since then. Which version of systemd are you
>using?
>
>-- Nicolas
>
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Samsung Galaxy Note 3 with K-9 Mail.
