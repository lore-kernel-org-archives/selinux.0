Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6CKTRwo025311
 for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2016 16:29:32 -0400
Received: by mail-oi0-f68.google.com with SMTP id w143so2476635oiw.2
 for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2016 13:28:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1c637b46-7352-b369-4891-4b695ff80b3b@tycho.nsa.gov>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-6-git-send-email-danielj@mellanox.com>
 <1c637b46-7352-b369-4891-4b695ff80b3b@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Jul 2016 16:28:56 -0400
Message-ID: <CAHC9VhSO4w-FK=9j7HgjzO4bGNRiajweWUBAWE3hMX0u0rOMxA@mail.gmail.com>
Subject: Re: [PATCH 05/12] selinux: Implement Infiniband PKey "Access" access
 vector
To: Dan Jurgens <danielj@mellanox.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: chrisw@sous-sol.org, Eric Paris <eparis@parisplace.org>,
 dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com,
 linux-rdma@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Mon, Jul 11, 2016 at 10:46 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I don't think we can/should add any more initial SIDs until we have
> dynamic discovery support for them.  At present, we'll have problems
> with old kernel with new policy and with new kernel with old policy when
> the number of initial SIDs changes.

Seems like a reasonable policy to me.

-- 
paul moore
www.paul-moore.com
