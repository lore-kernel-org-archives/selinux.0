Date: Tue, 24 Apr 2018 13:56:51 -0400 (EDT)
Message-Id: <20180424.135651.492329246141701047.davem@davemloft.net>
To: paul@paul-moore.com
Cc: dh.herrmann@gmail.com, linux-kernel@vger.kernel.org, jmorris@namei.org,
 teg@jklm.no, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, eparis@parisplace.org,
 serge@hallyn.com, netdev@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhSv6tacFb+nEs1cCUOj52Vu+wXD6ZPZ1r1W4pYXo0VJMQ@mail.gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
 <20180423133015.5455-3-dh.herrmann@gmail.com>
 <CAHC9VhSv6tacFb+nEs1cCUOj52Vu+wXD6ZPZ1r1W4pYXo0VJMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH 2/3] net/unix: hook unix_socketpair() into LSM
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Apr 2018 13:55:31 -0400

> On Mon, Apr 23, 2018 at 9:30 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Use the newly created LSM-hook for unix_socketpair(). The default hook
>> return-value is 0, so behavior stays the same unless LSMs start using
>> this hook.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>  net/unix/af_unix.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 68bb70a62afe..bc9705ace9b1 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -1371,6 +1371,11 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>>  static int unix_socketpair(struct socket *socka, struct socket *sockb)
>>  {
>>         struct sock *ska = socka->sk, *skb = sockb->sk;
>> +       int err;
>> +
>> +       err = security_unix_stream_socketpair(ska, skb);
>> +       if (err)
>> +               return err;
> 
> I recognize that AF_UNIX is really the only protocol that supports
> socketpair(2) at the moment, but I like to avoid protocol specific LSM
> hooks whenever possible.  Unless someone can think of a good
> objection, I would prefer to see the hook placed in __sys_socketpair()
> instead (and obviously drop the "unix_stream" portion from the hook
> name).

The counterargument is that after 30 years no other protocol has grown
usage of this operation. :-)
