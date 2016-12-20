Subject: Re: Issues Confined domain
To: Naina Emmanuel <nemmanuel1992@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Vit Mojzis <vmojzis@redhat.com>,
 selinux@tycho.nsa.gov
References: <CAN=9EoQa0EMEG26QVJ6vJvfFf5yBW6_eOc3XAifc9xuoijzwhA@mail.gmail.com>
 <CAN=9EoQx2Q2KA2sE58nKvinpU4Js1-Sctgn77MSQ5mGF-hi-2w@mail.gmail.com>
 <CAN=9EoSj3PXQt2ADBkMwJ9u9JBAnz9QfyORzG32aSOHk2ZqeTg@mail.gmail.com>
 <CAN=9EoQZfUoQ5Bty-D-B2dP1swZ=p5dAM9uJmywwWbcZnNPc9g@mail.gmail.com>
 <CAN=9EoSKzx4_C04D6iidyorb1t2xu9KtOt0sSU4zRxVNQSMeaA@mail.gmail.com>
 <CAN=9EoQgxLfMvAZZw0mY9U6wADChBe7a7-dsLusLaAdwcKwT2w@mail.gmail.com>
 <CAN=9EoQOHP=DDowW-zD6FOpEze5H+9wjSbi47Bf9vekmddH85Q@mail.gmail.com>
 <CAN=9EoS9u96H7t8ebuSjK=jLOcOq66Nds70g0sY4W_ELZk_J1Q@mail.gmail.com>
 <CAN=9EoR6KXaWcngW5tUDtnEYiAhRQWS1z-iXsnpgsc=L7oQ3-w@mail.gmail.com>
 <CAN=9EoTMHD3ridU7CZ5bgyXUaRN-vMcvr3T3TrSaHigstWn2mA@mail.gmail.com>
 <CAN=9EoTXW=31mCS-GtsUkhPB3CCj6_jdiiC3vq4pVAV_72DFZg@mail.gmail.com>
Cc: masoom alam <masoom.alam@gmail.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <ce42b511-76db-f910-9034-06ca5224c7f5@redhat.com>
Date: Tue, 20 Dec 2016 13:34:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAN=9EoTXW=31mCS-GtsUkhPB3CCj6_jdiiC3vq4pVAV_72DFZg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------20966082B2208E293615BD30"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------20966082B2208E293615BD30
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

You would want to setup root as sysadm_u not staff_u.

You should use sudo to change roles not su.

If you can not login as a non root user then you probably have a
labeling issue.

restorecon -R -v -F /home



On 12/20/2016 01:30 PM, Naina Emmanuel wrote:
> Good morning sir,
> I have questions about my finding....
> Working on SELinux centos 7 (enforcing mode). I don't want any
> unconfined_t label on my system, so I have confined my root and my
> users through
> # /usr/sbin/semanage login -a -s staff_u root
> # /usr/sbin/semanage login -a -s staff_u test
> Q: In enforcing mode I could switch user(su) but I am not able to ssh
> or login to root or any user that I am confining, it gives permission
> denied error?
> Same is the case when I am confining in staff_u or sysadm_u domain  
>
>
>
> Please help in this regard
> Thanks


--------------20966082B2208E293615BD30
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>You would want to setup root as sysadm_u not staff_u.</p>
    <p>You should use sudo to change roles not su.</p>
    <p>If you can not login as a non root user then you probably have a
      labeling issue.</p>
    <p>restorecon -R -v -F /home</p>
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 12/20/2016 01:30 PM, Naina Emmanuel
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAN=9EoTXW=31mCS-GtsUkhPB3CCj6_jdiiC3vq4pVAV_72DFZg@mail.gmail.com"
      type="cite">
      <div dir="auto">Good morning sir,
        <div dir="auto">I have questions about my finding....</div>
        <div dir="auto">Working on SELinux centos 7 (enforcing mode). I
          don't want any unconfined_t label on my system, so I have
          confined my root and my users through</div>
        <div dir="auto"># /usr/sbin/semanage login -a -s staff_u root</div>
        <div dir="auto">
          <div dir="auto" style="font-family:sans-serif">#
            /usr/sbin/semanage login -a -s staff_u test</div>
          <div dir="auto" style="font-family:sans-serif">Q: In enforcing
            mode I could switch user(su) but I am not able to ssh or
            login to root or any user that I am confining, it gives
            permission denied error?</div>
          <div dir="auto" style="font-family:sans-serif">Same is the
            case when I am confining in staff_u or sysadm_u domain  </div>
          <div dir="auto" style="font-family:sans-serif"><br>
          </div>
          <div dir="auto" style="font-family:sans-serif"><br>
          </div>
          <div dir="auto" style="font-family:sans-serif"><br>
          </div>
          <div dir="auto" style="font-family:sans-serif">Please help in
            this regard</div>
          <div dir="auto" style="font-family:sans-serif">Thanks</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------20966082B2208E293615BD30--
