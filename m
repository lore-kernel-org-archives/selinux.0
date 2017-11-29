Message-ID: <1511972400.10464.16.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 29 Nov 2017 11:20:00 -0500
In-Reply-To: <CAPMH7-9JxKDOO8dMC_wZwRTm+Z8G4gOPvYZxf3obsB1GBGSMhQ@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <1511970015.10464.10.camel@tycho.nsa.gov>
 <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
 <1511971345.10464.14.camel@tycho.nsa.gov>
 <CAPMH7-9JxKDOO8dMC_wZwRTm+Z8G4gOPvYZxf3obsB1GBGSMhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> After enabling the unconfined module and after reboot also, Still
> showing the same id context.
> 
> Is there any way to make the id context to normal state again ? 

Hmmm...try resetting all booleans too?  semanage boolean -D

Or you could be drastic and completely reset your policy:
mv /etc/selinux/targeted /etc/selinux/targeted.old
yum reinstall selinux-policy-targeted
