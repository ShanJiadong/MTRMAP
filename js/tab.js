// == ֵ�Ƚ�  === ���ͱȽ� $(id) ---->  document.getElementById(id)
function $(id){
    return typeof id === 'string' ? document.getElementById(id):id;
}
 
// ��ҳ��������
window.onload = function(){
    // �õ����еı���(li��ǩ) �� �����Ӧ������(div)
    var titles = $('tab-header').getElementsByTagName('li');
    var divs = $('tab-content').getElementsByClassName('dom');
    // �ж�
    if(titles.length != divs.length) return;
    // ����
    for(var i=0; i<titles.length; i++){
        // ȡ��li��ǩ
        var li = titles[i];
        li.id = i;
//        console.log(li);
        // ���������ƶ�
        li.onmousemove = function(){
            for(var j=0; j<titles.length; j++){
                titles[j].className = '';
                divs[j].style.display = 'none';
            }
            this.className = 'selected';
            divs[this.id].style.display = 'block';
        }
    }
}
