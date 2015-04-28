MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <553E8CA6.70404@tycho.nsa.gov>
References: <1430162024-29420-1-git-send-email-nnk@google.com>
 <553E8CA6.70404@tycho.nsa.gov>
Date: Tue, 28 Apr 2015 13:10:45 +0200
Message-ID: <CAPzO=NxjmqB386c=Cxbmh3TCfB82U_0SHWu81897iC_eHgE=Xg@mail.gmail.com>
Subject: Re: [PATCH] Don't assume SELinux code is already installed on host
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 27, 2015 at 9:23 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Using relative paths within the selinux source tree is problematic in
> the other case since historically we have distributed individual
> tarballs for each components and not the entire tree.  Actually, it was
> the other way around originally but Red Hat wanted us to break it up
> into separate tarballs for inclusion in separate packages in the Linux
> distributions.

Yes, in Gentoo we too use separate tarballs for all the userspace
applications and libraries, so this would definitely break our builds.

We are able to install and build up a SELinux system from a
non-SELinux system using the current instruction sets (so we don't
assume it is installed either). The most important part is the order
in which installations are done afaik.

Wkr,
  Sven Vermeulen
