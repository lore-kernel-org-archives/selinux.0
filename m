Subject: Re: SE Android on Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: Subramani Venkatesh <selinuxv31@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
References: 
	 <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	 <1330702776.2616.43.camel@moss-pluto>
	 <CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	 <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Mar 2012 15:26:29 -0500
Message-ID: <1330719989.2616.100.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 11:51 -0600, Bryan Hinton wrote:
> Here is the latest policy that I am using.

BTW, I think we will ultimately need some per-device policy files that
get merged into the policy, much as there are per-device
ueventd.<board>.rc and init.<board>.rc files.  At least for
file_contexts, and possibly for policy rules as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
