Message-ID: <1492704534.669.5.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: remove lock files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
Date: Thu, 20 Apr 2017 12:08:54 -0400
In-Reply-To: <1142061194.203411.1492703788891@pim.register.it>
References: <58517705.198270.1492699110308@pim.register.it>
 <1492703075.669.1.camel@tycho.nsa.gov>
 <1967496203.202650.1492703110228@pim.register.it>
 <1492703796.669.3.camel@tycho.nsa.gov>
 <1142061194.203411.1492703788891@pim.register.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-20 at 17:56 +0200, Guido Trentalancia wrote:
> Hello and thanks for getting back.
> 
> If it doesn't have any side-effect (as it should), then I think it's
> preferable that the filesystem is kept clean.
> 
> It can be confusing too: because lock files are generally considered
> "active" when present in the filesystem.
> 
> Well, you've heard my opinion and you have the very simple patch now.
> Feel free to do whatever you and the authors like with it...

Hmm..see for example the "DON'T unlink" section of:
http://world.std.com/~swmcd/steven/tech/flock.html
