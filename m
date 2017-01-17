Message-ID: <1484689529.20454.23.camel@tycho.nsa.gov>
Subject: Re: Wrong alignment when listing user/login with semanage in French
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>
Date: Tue, 17 Jan 2017 16:45:29 -0500
In-Reply-To: <2b54cfbd-56fb-a074-eeb7-11ebe02b9ecd@debian.org>
References: <2b54cfbd-56fb-a074-eeb7-11ebe02b9ecd@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-01-14 at 13:48 +0100, Laurent Bigonville wrote:
> Hi,
> 
> Not sure I already posted this on the ML.
> 
> When listing the user/login with semanage (login/user -l) in French
> (and 
> probably in other languages as well), the columns headers are not 
> properly aligned.
> 
> This makes it sometimes difficult to read the output(and it's ugly), 
> see: https://i.imgur.com/zhZkebc.png
> 
> Some of the translations should maybe be fixed in this case to make
> them 
> shorter, but the alignment should probably be dynamic.
> 
> RHEL/Fedora[1] contains the python binding for libsmartcols, maybe
> this 
> could be used to do the formating?

Not sure.  Is it readily available in other distributions and in
OpenEmbedded?

> 
> Regards,
> 
> Laurent Bigonvlle
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1369558
