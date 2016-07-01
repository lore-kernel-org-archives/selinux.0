Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u61IsDpw014927
 for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2016 14:54:13 -0400
Received: by mail-oi0-f50.google.com with SMTP id s66so122656015oif.1
 for <selinux@tycho.nsa.gov>; Fri, 01 Jul 2016 11:54:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM4PR0501MB2257ADAB527392547179F779C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-5-git-send-email-danielj@mellanox.com>
 <CAGH-KgvtN8T7e5bKq0jJZvSzrGfFwA2VpmPf5gJuqdLZi6odEw@mail.gmail.com>
 <6662b3b0-6897-8775-dc30-2757387428e4@schaufler-ca.com>
 <AM4PR0501MB2257ADAB527392547179F779C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 1 Jul 2016 14:54:11 -0400
Message-ID: <CAGH-KgtKkCvynjRJKAvVxdQdCj727bH0eaHBLj3RJY2=GW=D9g@mail.gmail.com>
Subject: Re: [PATCH 04/12] selinux: Allocate and free infiniband security hooks
To: Daniel Jurgens <danielj@mellanox.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 30, 2016 at 5:48 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 6/30/2016 4:06 PM, Casey Schaufler wrote:
>> On 6/30/2016 1:42 PM, Paul Moore wrote:

>>>>  };
>>>>
>>>>  /**
>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>>> index 3f6780b..e522acb 100644
>>>> --- a/include/rdma/ib_verbs.h
>>>> +++ b/include/rdma/ib_verbs.h
>>>> @@ -1454,6 +1454,7 @@ struct ib_qp {
>>>>         void                   *qp_context;
>>>>         u32                     qp_num;
>>>>         enum ib_qp_type         qp_type;
>>>> +       struct ib_qp_security  *qp_sec;
>>> See my earlier question/comment about just using a void pointer here.
>>
>> I think that this is in response to my comments to the
>> effect that I would like to see the LSM infrastructure
>> using the inode like (inode->i_security) to the xfrm
>> (void *) approach. I haven't been looking at the IB patches
>> too carefully to date. It's possible I have not been clear.
>
> My understanding at the time was that by using something other than a void * different security modules could maintain their own opaque blobs with in and keep the same prototype for the hook.  It's possible I misunderstood you, but it made sense to me.  I don't know of any plans for other security modules to support Infiniband, but this leaves the door open.

All of what you describe above can still happen with a void pointer;
in some ways it is even easier with a void pointer.

-- 
paul moore
security @ redhat
