MIME-Version: 1.0
In-Reply-To: <CAN=9EoRdmo3YSXBQxANk7o9bVYF5-CHiZcS9-oau9Hr7oRNg7g@mail.gmail.com>
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
 <ce42b511-76db-f910-9034-06ca5224c7f5@redhat.com>
 <CAN=9EoRdmo3YSXBQxANk7o9bVYF5-CHiZcS9-oau9Hr7oRNg7g@mail.gmail.com>
From: Naina Emmanuel <nemmanuel1992@gmail.com>
Date: Tue, 20 Dec 2016 10:40:03 -0800
Message-ID: <CAN=9EoQCyqLvna=z2Vhs-nsODGqrt0kJo72a5B79UGD=keZmdw@mail.gmail.com>
Subject: Re: Issues Confined domain
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 masoom alam <masoom.alam@gmail.com>, Vit Mojzis <vmojzis@redhat.com>
Content-Type: multipart/alternative; boundary=001a1146f0904c220005441b5de5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1146f0904c220005441b5de5
Content-Type: text/plain; charset=UTF-8

su for switching users means I could switch from test to root and root to
test a but I doesn't allow ssh or direct login for root

On 20-Dec-2016 11:34 pm, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

You would want to setup root as sysadm_u not staff_u.

You should use sudo to change roles not su.

If you can not login as a non root user then you probably have a labeling
issue.

restorecon -R -v -F /home



On 12/20/2016 01:30 PM, Naina Emmanuel wrote:

Good morning sir,
I have questions about my finding....
Working on SELinux centos 7 (enforcing mode). I don't want any unconfined_t
label on my system, so I have confined my root and my users through
# /usr/sbin/semanage login -a -s staff_u root
# /usr/sbin/semanage login -a -s staff_u test
Q: In enforcing mode I could switch user(su) but I am not able to ssh or
login to root or any user that I am confining, it gives permission denied
error?
Same is the case when I am confining in staff_u or sysadm_u domain



Please help in this regard
Thanks

--001a1146f0904c220005441b5de5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">su for switching users means I could switch from test to =
root and root to test a but I doesn&#39;t allow ssh or direct login for roo=
t</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 20-Dec-=
2016 11:34 pm, &quot;Daniel J Walsh&quot; &lt;<a href=3D"mailto:dwalsh@redh=
at.com">dwalsh@redhat.com</a>&gt; wrote:<br type=3D"attribution"><blockquot=
e class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>You would want to setup root as sysadm_u not staff_u.</p>
    <p>You should use sudo to change roles not su.</p>
    <p>If you can not login as a non root user then you probably have a
      labeling issue.</p>
    <p>restorecon -R -v -F /home</p><div class=3D"elided-text">
    <p><br>
    </p>
    <br>
    <div class=3D"m_-4766347967455461516moz-cite-prefix">On 12/20/2016 01:3=
0 PM, Naina Emmanuel
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"auto">Good morning sir,
        <div dir=3D"auto">I have questions about my finding....</div>
        <div dir=3D"auto">Working on SELinux centos 7 (enforcing mode). I
          don&#39;t want any unconfined_t label on my system, so I have
          confined my root and my users through</div>
        <div dir=3D"auto"># /usr/sbin/semanage login -a -s staff_u root</di=
v>
        <div dir=3D"auto">
          <div dir=3D"auto" style=3D"font-family:sans-serif">#
            /usr/sbin/semanage login -a -s staff_u test</div>
          <div dir=3D"auto" style=3D"font-family:sans-serif">Q: In enforcin=
g
            mode I could switch user(su) but I am not able to ssh or
            login to root or any user that I am confining, it gives
            permission denied error?</div>
          <div dir=3D"auto" style=3D"font-family:sans-serif">Same is the
            case when I am confining in staff_u or sysadm_u domain =C2=A0</=
div>
          <div dir=3D"auto" style=3D"font-family:sans-serif"><br>
          </div>
          <div dir=3D"auto" style=3D"font-family:sans-serif"><br>
          </div>
          <div dir=3D"auto" style=3D"font-family:sans-serif"><br>
          </div>
          <div dir=3D"auto" style=3D"font-family:sans-serif">Please help in
            this regard</div>
          <div dir=3D"auto" style=3D"font-family:sans-serif">Thanks</div>
        </div>
      </div>
    </blockquote>
    <br>
  </div></div>

</blockquote></div><br></div>

--001a1146f0904c220005441b5de5--
