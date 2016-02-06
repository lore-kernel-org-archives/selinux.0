From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: selinux_set_callback() problem
Date: Sat, 6 Feb 2016 12:58:00 +1100
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <201602050832.20068.russell@coker.com.au>
 <56B4E9F1.8070904@tycho.nsa.gov>
In-Reply-To: <56B4E9F1.8070904@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201602061258.00611.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 6 Feb 2016 05:29:05 AM Stephen Smalley wrote:
> On 02/04/2016 04:32 PM, Russell Coker wrote:
> > type=USER_AVC msg=audit(1454447396.743:48359): pid=1 uid=0
> > auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> > msg='avc:  denied  { status } for auid=0 uid=0 gid=0
> > path="/lib/systemd/system/reboot.target"
> > cmdline="reboot"
> > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:systemd_unit_file_t:SystemLow tclass=service
> > exe="/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'
> > 
> > I'm seeing entries like the above from the Debian/Jessie systemd in
> > audit.log. Below is the relevant code from the systemd source:
> > 
> > _printf_(2, 3) static int log_callback(int type, const char *fmt, ...) {
> > 
> >          va_list ap;
> > 
> > #ifdef HAVE_AUDIT
> > 
> >          if (get_audit_fd() >= 0) {
> >          
> >                  _cleanup_free_ char *buf = NULL;
> >                  int r;
> >                  
> >                  va_start(ap, fmt);
> >                  r = vasprintf(&buf, fmt, ap);
> >                  va_end(ap);
> >                  
> >                  if (r >= 0) {
> >                  
> >                          audit_log_user_avc_message(get_audit_fd(),
> > 
> > AUDIT_USER_AVC, buf,
> > NULL, NULL, NULL, 0);
> > 
> >                          return 0;
> >                  
> >                  }
> >          
> >          }
> > 
> > #endif
> > 
> >          va_start(ap, fmt);
> >          log_metav(LOG_USER | LOG_INFO, __FILE__, __LINE__, __FUNCTION__,
> >          fmt,
> > 
> > ap);
> > 
> >          va_end(ap);
> >          
> >          return 0;
> > 
> > }
> > 
> > Then the following line is in the access_init() function to enable it:
> > 
> > selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback)
> > log_callback);
> > 
> > Any suggestions as to where I should start working on this?
> > 
> > Sorry if it's a newbie question, I haven't worked on SE Linux library
> > code for a while.
> 
> What exactly is the problem?  Is it that the scontext has a raw context
> and the tcontext has a translated context?  Or is it that it was denied
> when it should have been allowed?
> 
> The callback itself is obviously being executed or you wouldn't have the
> audit message at all.

The problem is a translated context which breaks audit2allow.  Even if it 
didn't break audit2allow it wouldn't be a good thing to have as the text 
representations can (in theory at least) change.

# audit2allow -l < /var/log/audit/audit.log
libsepol.mls_from_string: invalid MLS context SystemLow
libsepol.mls_from_string: could not construct mls context structure
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert 
system_u:object_r:systemd_unit_file_t:SystemLow to sid


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
