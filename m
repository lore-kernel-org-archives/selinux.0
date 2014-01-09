Message-ID: <52CEE3A9.9010307@tycho.nsa.gov>
Date: Thu, 09 Jan 2014 13:00:09 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tawfiq Shah <tawfiqshah@gmail.com>, russell@coker.com.au
Subject: Re: question about basic selinux concept
References: <2a7b84d3.10951.143524a4a81.Coremail.bigclouds@163.com>
 <201401022053.56630.russell@coker.com.au>
 <CAP_GsaT1K32RbaqiqtK8z+P4LciQJDN7nRCVcd-7jF9xCbaPTA@mail.gmail.com>
In-Reply-To: <CAP_GsaT1K32RbaqiqtK8z+P4LciQJDN7nRCVcd-7jF9xCbaPTA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2014 12:52 PM, Tawfiq Shah wrote:
> Hi all,
> Is there any documentation on which LSM hook function is responsible for
> sending the request to the security server and the function responsible for
> relaying the decision of the security server to the LSM enforcement hooks?

The most accurate and up-to-date documentation is the code, but if you
prefer non-code descriptions, some possibilities would be:
http://www.nsa.gov/research/_files/selinux/papers/module-abs.shtml

http://www.usenix.org/events/sec02/full_papers/wright/wright.pdf

http://www.kroah.com/linux/talks/ols_2002_lsm_paper/lsm.pdf
