Subject: Re: Embedded SELinux: SELinux via NFS with different policies on
 client and server
To: Selinux@tycho.nsa.gov
References: <f805c577-6238-d99d-bd9d-5e1f63f6371e@os-t.de>
 <87af2abc-ebfc-ffaf-7c7e-850c0cf566e9@tycho.nsa.gov>
 <3e9096f8-fc7b-9284-f144-27564b9183f1@os-t.de>
From: Ralf Spenneberg <ralf@os-t.de>
Message-ID: <e4c8694a-7981-db14-b51c-213d57da2b91@os-t.de>
Date: Wed, 24 Aug 2016 15:59:58 +0200
MIME-Version: 1.0
In-Reply-To: <3e9096f8-fc7b-9284-f144-27564b9183f1@os-t.de>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Stephen,

thanks a lot again. It worked like a charm.
Even the labeling from the host using setfiles and the alternate root
path worked well.

Now the fun starts (generating policies ;-)

Kind regards,

Ralf


Am 24.08.2016 um 14:54 schrieb Ralf Spenneberg:
> Am 24.08.2016 um 14:48 schrieb Stephen Smalley:
>> On 08/24/2016 08:14 AM, Ralf Spenneberg wrote:
>>> Hi
>>>
>>> we are working on SELinux in the embedded area. For development we are
>>> using a nfsroot based approach. We successfully setup the nfs server
>>> supporting security labels and are able to boot from the share using
>>> nfsroot. We would like to label the files from the server so the relabel
>>> process on the client may be omitted.
>>> The embedded device requires a different policy that the nfs-server.  We
>>> are basing our policy on the refpolicy-2.20151208 and only compile the
>>> required modules.
>>>
>>> When setting any label on the server the client always displays
>>> unlabeled_t. The same happens if we set the label on the client. The
>>> server displays unlabeled_t. Is there a way that both might agree on the
>>> same label?
>>> By the way: The server is x86_64 (kernel 4.5.7) while the client is
>>> armv7l 32bit (3.12.10).
>>>
>>> But since the labels are stored in text this should not pose any
>>> problems, does it?
>>
>> Correct.  You said that they require a different policy.  Is one running
>> a MLS-enabled (MCS or MLS) policy, while the other is not?  Or is the
>> user/role/type you are using in the label defined in both policies?
>>
>> Look at your dmesg output on both the client and server for messages
>> from SELinux, e.g.
>> SELinux: inode=... on dev=... was found to have an invalid context=...
>> This indicates you may need to relabel the inode or the filesystem in
>> question.
>>
> Well, somehow the kernel messages might indicate this:
> 
> On the server:
> ]$ ls -lZ /test/
> insgesamt 56
> -rw-------. 1 root root system_u:object_r:unlabeled_t:s0 55138 24. Aug
> 13:35 audit.log
> -rw-r--r--. 1 root root system_u:object_r:bin_t:s0           0 23. Aug
> 10:45 test
> -rw-r--r--. 1 root root system_u:object_r:bin_t:s0           0 24. Aug
> 13:39 test2
> 
> On the client:
> / # mount.nfs4  10.42.0.33:/ /test
> SELinux: initialized (dev 0:20, type nfs4), uses native labeling
> / # ls -lZ /test
> nfs_setsecurity() system_u:object_r:bin_t:s0 27
> security_inode_notifysecctx() -22
> nfs_setsecurity() system_u:object_r:bin_t:s0 27
> security_inode_notifysecctx() -22
> -rw-------    1     55138 Aug 24  2016 system_u:object_r:unlabeled_t
> audit.log
> -rw-r--r--    1         0 Aug 23  2016 system_u:object_r:unlabeled_t    test
> -rw-r--r--    1         0 Aug 24  2016 system_u:object_r:unlabeled_t
> test2
> 
> So I am getting the nfs_setsecurity messages referring to the
> security_inode_notifysecctx.
> 
> Looking at the output of the client apparently no MLS is used (missing :s0)
> I will look into it and get back to you asap. Thanks a lot for the pointer.
> 
> Kind regards,
> 
> Ralf
> 

-- 
OpenSource Training Ralf Spenneberg     http://www.os-t.de
Am Bahnhof 3-5                          48565 Steinfurt         Germany
Fon: +49(0)2552 638 755                 Fax: +49(0)2552 638 757
