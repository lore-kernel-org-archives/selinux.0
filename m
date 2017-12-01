Date: Fri, 1 Dec 2017 14:35:04 -0500 (EST)
From: Simon Sekidde <ssekidde@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Aman Sharma <amansh.sharma5@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
In-Reply-To: <1512156497.5144.17.camel@tycho.nsa.gov>
References: <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
 <20171130201920.GA32637@julius.enp8s0.d30>
 <CAPMH7-9zGFSRz3qPJup2y8=zNo6X1dRgNf8gUWv=d+UK1EdO9A@mail.gmail.com>
 <935734452.20069825.1512155793791.JavaMail.zimbra@redhat.com>
 <1512156497.5144.17.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Stephen Smalley" <sds@tycho.nsa.gov>
> To: "Simon Sekidde" <ssekidde@redhat.com>, "Aman Sharma" <amansh.sharma5@gmail.com>
> Cc: "SELinux" <selinux@tycho.nsa.gov>
> Sent: Friday, December 1, 2017 2:28:17 PM
> Subject: Re: Qwery regarding Selinux Change Id context
> 
> On Fri, 2017-12-01 at 14:16 -0500, Simon Sekidde wrote:
> > 
> > ----- Original Message -----
> > > From: "Aman Sharma" <amansh.sharma5@gmail.com>
> > > To: "SELinux" <selinux@tycho.nsa.gov>
> > > Sent: Thursday, November 30, 2017 11:26:21 PM
> > > Subject: Re: Fwd: Qwery regarding Selinux Change Id context
> > > 
> > > Hi ,
> > > 
> > > mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old
> > > 
> > > This targeted folder is not there.
> > > 
> > > After searching I got the below result :
> > > 
> > > find / -type d -name "*targeted" -print
> > > 
> > > /usr/share/selinux/targeted
> > > /etc/selinux/targeted
> > > 
> > > Pleas let me know your comments.
> > > 
> > 
> > Run
> > 
> > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > yum reinstall selinux-policy-targeted
> 
> He already tried that and it allegedly didn't help.  It also seems to
> leave you without a /etc/selinux/targeted/active/seusers file for some
> reason, such that semanage login -l shows nothing.  But you can recover
> by copying /etc/selinux/targeted/seusers to
> /etc/selinux/targeted/active/seusers.  That's a bug.
> 

Interesting. Thanks for spotting this. 

> > 
> > Also what does this output show
> > 
> > ps -aelfZ | grep -i ssh
> > 
> > > 
> > > On Fri, Dec 1, 2017 at 1:49 AM, Dominick Grift <dac.override@gmail.
> > > com>
> > > wrote:
> > > 
> > > > On Thu, Nov 30, 2017 at 11:10:43AM +0530, Aman Sharma wrote:
> > > > > Hi Stephen,
> > > > > 
> > > > > After reseting Selinux targeted folder also (the steps you
> > > > > mentioned in
> > > > 
> > > > the
> > > > > earlier mail), Still its showing the same Id context i.e.
> > > > > 
> > > > > *id*
> > > > > *uid=0(root) gid=0(root) groups=0(root)
> > > > > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > > > > *[root@cucm2 ~]# id -Z*
> > > > > *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > > > > 
> > > > > *And semanage login -l is showing blank output. *
> > > > > 
> > > > > *Do you have any idea about this.*
> > > > > 
> > > > > *Thanks*
> > > > > *Aman*
> > > > 
> > > > Try the same procedure again but this time also do before
> > > > reinstalling:
> > > > 
> > > > mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old
> > > > 
> > > > > 
> > > > > 
> > > > > On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley <sds@tycho.ns
> > > > > a.gov>
> > > > 
> > > > wrote:
> > > > > 
> > > > > > On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:
> > > > > > > After resetting boolean also, showing the same id context.
> > > > > > 
> > > > > > And did you try fully resetting your policy as I suggested:
> > > > > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > > > > yum reinstall selinux-policy-targeted
> > > > > > reboot
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <sds@tycho
> > > > > > > .nsa.gov>
> > > > > > > wrote:
> > > > > > > > On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
> > > > > > > > > Hi Stephen,
> > > > > > > > > 
> > > > > > > > > After enabling the unconfined module and after reboot
> > > > > > > > > also, Still
> > > > > > > > > showing the same id context.
> > > > > > > > > 
> > > > > > > > > Is there any way to make the id context to normal state
> > > > > > > > > again ?
> > > > > > > > 
> > > > > > > > Hmmm...try resetting all booleans too?  semanage boolean
> > > > > > > > -D
> > > > > > > > 
> > > > > > > > Or you could be drastic and completely reset your policy:
> > > > > > > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > > > > > > yum reinstall selinux-policy-targeted
> > > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > --
> > > > > > > 
> > > > > > > Thanks
> > > > > > > Aman
> > > > > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > > > 
> > > > > 
> > > > > 
> > > > > --
> > > > > 
> > > > > Thanks
> > > > > Aman
> > > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > > 
> > > > --
> > > > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> > > > 6B02
> > > > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7
> > > > B6B02
> > > > Dominick Grift
> > > > 
> > > 
> > > 
> > > 
> > > --
> > > 
> > > Thanks
> > > Aman
> > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > 
> > 
> > 
> 

-- 
Simon Sekidde 
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
